# This javascript module handles the opening & closing of dialogs and overlays when required.
Journal.Dialog =

  # Sets an array of overlay methods to be executed
  overlayCloseActions: new Array

  # Adds a new overlay to the page. Accepts a method which should be executed
  # when the overlay is triggered. If an overlay is already in place when this
  # is called, the method you pass will be added to the stack for execution
  # when the current overlay is removed.
  addOverlay: (clickAction)->
    this.overlayCloseActions.push(clickAction)
    unless $('div.overlay').length
      theOverlay = $("<div class='overlay'></div>").appendTo('body')
      theOverlay.fadeIn 'fast'
      unless clickAction == false
        theOverlay.on 'click', => this.closeOverlay()

  # Closes the any overlay which is in place
  closeOverlay: ->
    theOverlay = $('div.overlay')
    if theOverlay.length
      $.each this.overlayCloseActions, (i,action)-> action.call(theOverlay)
      theOverlay.fadeOut 'fast', -> theOverlay.remove()

  # Open a new dialog which will accept a number of possible options.
  #
  #   id         => an ID for the dialog. Only one dialog for each ID can be
  #                 display at once.
  #
  #   url        => open a dialog containing the HTML at the given URL. When
  #                 displaying using a URL, the dialog will open immediately
  #                 and containing a spinner until the data is loaded.
  #
  #   html       => open a dialog containing the html passed to this method
  #
  #   header     => the content in the header
  #
  open: (options={})->
    $("div#dialog-#{options.id}").remove()
    dialogTemplate = $("<div class='dialog #{options.id}' id='dialog-#{options.id}'></div>")
    insertedDialog = dialogTemplate.appendTo($('body'))

    if options.width?
      insertedDialog.css('width', "#{options.width}px")
      insertedDialog.css('margin-left', "-#{options.width / 2}px")
    if options.url?
      insertedDialog.addClass 'ajax'
      insertedDialog.addClass 'loading'
      $.ajax
        url: options.url
        success: (data)->
          insertedDialog.html(data)
          insertedDialog.removeClass 'loading'
          options.afterLoad.call(insertedDialog) if options.afterLoad?
          insertedDialog.prepend("<div class='header'>#{options.header}</div>") if options.header?
    else if options.html?
      insertedDialog.addClass 'static'
      insertedDialog.html(options.html)
      options.afterLoad.call(insertedDialog) if options.afterLoad?
    else
      console.log "Dialog could not be displayed. Invalid options passed."
      console.log options
      return false

    insertedDialog.fadeIn('fast')
    if options.closable? && options.closable == false
      this.addOverlay false
    else
      this.addOverlay -> insertedDialog.fadeOut('fast')




#
# Helpers
#
Journal.Helpers =

  autoOpenDialog: (link)->
    options = {url: link.attr('href')}
    options.id = Journal.Helpers.parameterize(options.url)
    options.width = link.data('dialogWidth') if link.data('dialogWidth')
    options.header = link.data('dialog-header') if link.data('dialog-header')
    options.afterLoad = ->
      $('form', this).on 'submit', ->
        Journal.Helpers.submitForm form: $(this)
    Journal.Dialog.open options

  submitForm: (options={})->
    $.ajax
      url:      options.form.attr('action')
      method:   if $('input[name=_method]', options.form).length then $('input[name=_method]', options.form).val() else options.form.attr('method')
      data:     options.form.serialize()
      dataType: 'json'
      success:  (data)->
        if data.redirect?
          window.location.replace(data.redirect)
        else
          options.success()
      error:    (xhr, textStatus, errorThrown)->
        if xhr.status == 422
          if xhr.responseJSON
            console.log xhr.responseJSON.errors
            alert xhr.responseJSON.errors
          else
            alert "Validation error"
        else
          alert "An error ocurred while sending data. Please try again later."
    false

  parameterize: (string)->
    string = string.replace(/[^a-z0-9\-_]+/g, '-')
    string = string.replace(/-{2,}/g, '-')
    string = string.replace(/^-|-$/g, '')
    string.toLowerCase()

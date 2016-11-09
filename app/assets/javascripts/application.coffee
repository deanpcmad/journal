##= require jquery
##= require jquery_ujs
##= require bootstrap-sprockets
##= require_self
##= require moment
##= require fullcalendar
##= require_tree .

window.Journal = {}

$(document).ready ->
  $('#calendar').fullCalendar
    events: "/entries.json",
    selectable: true,
    selectHelper: true

    select: (start, end, allDay) ->
      date = moment(start).format()
      $("#entry_date").val(date)

      $("#createEntryModal").modal "show"
      return

    eventClick: (event) ->
      if event.url
        Journal.Helpers.autoOpenDialog($(this))
        false

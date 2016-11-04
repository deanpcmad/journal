class AttachmentsController < ApplicationController

  before_action { params[:entry_id] && @entry = Entry.find(params[:entry_id]) }
  before_action { params[:id] && @attachment = @entry.attachments.find(params[:id]) }

  def index
    @attachments = @entry.attachments.all
  end

  def show
  end

  def new
    @attachment = Attachment.new
    render action: "form"
  end

  def edit
    render action: "form"
  end

  def create
    @attachment = @entry.attachments.build(safe_params)
    if @attachment.save
      redirect_to @entry
    else
      render :new
    end
  end

  def update
    if @attachment.update_attributes(safe_params)
      redirect_to @entry
    else
      render :new
    end
  end

  def destroy
    @attachment.destroy
    redirect_to @entry
  end

  private

  def safe_params
    params.require(:attachment).permit(:file)
  end

end

class EntriesController < ApplicationController

  before_action { params[:id] && @entry = Entry.find(params[:id]) }

  def index
    # @entries = Entry.all.order(date: :desc)

    params[:start] ? st = Date.parse(params[:start]) : st = Date.today
    params[:end] ? et = Date.parse(params[:end]).end_of_day : et = Date.today.end_of_day

    @entries = Entry.ordered.where(date: st..et)
  end

  def show
    @attachments = @entry.attachments.load
    render layout: false
  end

  def new
    @entry = Entry.new
    render action: "form"
  end

  def edit
    render action: "form"
  end

  def create
    @entry = Entry.new(safe_params)
    if @entry.save
      redirect_to entries_path
    else
      render action: "form"
    end
  end

  def update
    if @entry.update_attributes(safe_params)
      redirect_to entries_path
    else
      render action: "form"
    end
  end

  private

  def safe_params
    params.require(:entry).permit(:date, :content)
  end

end

class EntriesController < ApplicationController

  before_action { params[:id] && @entry = Entry.find(params[:id]) }

  def index
    @entries = Entry.all.order(created_at: :desc)
  end

  def show
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
      redirect_to @entry
    else
      render :new
    end
  end

  def update
    if @entry.update_attributes(safe_params)
      redirect_to @entry
    else
      render :new
    end
  end

  private

  def safe_params
    params.require(:entry).permit(:date, :content)
  end

end

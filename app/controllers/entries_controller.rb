class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: %i[show edit destroy]

    def index
      @entries = current_user.entries
      @main_entry = current_user.entries.first
    end

    def show
    end

  def new 
    @entry = Entry.new
  end

  def create 
    @entry = current_user.entries.new(entry_params)

    if @entry.save
      flash.now[:notice] = "Quiz <strong>#{@entry.name}</strong> - created successfully.".html_safe
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream {}
      end
    else
      # flash:now[:alert] = "Quiz creation failed.".html_safe
      render :new, status: :unprocessable_entity
    end
  end

  def edit 
  
  end
  

  def destroy
    @entry.destroy
    flash.now[:notice] = "Quiz <strong>#{@entry.name}</strong> - deleted successfully.".html_safe
    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream {}
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:name, :description)
  end

  def set_entry
    @entry = current_user.entries.find(params[:id])
  end
end

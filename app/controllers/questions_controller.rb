class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, except: []
  before_action :set_question, only: %i[show edit update destroy]

  def index
     @entry = current_user.entries.find(params[:entry_id]) # or use before_action
    @questions = @entry.questions
    @question = @entry.questions.new
  end

  def show
  respond_to do |format|
    format.html
  end
end


  def new
    @entry = current_user.entries.find(params[:entry_id]) # or use before_action :set_entry
    @question = @entry.questions.new
  end

def create
  @question = @entry.questions.new(question_params)

  if @question.save
      if params[:question][:answer_text].present?
      @question.answers.create(answer_text: params[:question][:answer_text])
    end
    flash.now[:notice] = "Question created successfully."
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Question created successfully." }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("flash", partial: "shared/flash"),
        ]
      end
    end
  else
    flash.now[:alert] = "Failed to create question."
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("flash", partial: "shared/flash"),
        ]
      end
    end
  end
end



  def edit
  end

  def update
    if @question.update!(question_params)
      flash.now[:notice] = "Question updated successfully.".html_safe
      respond_to do |format|
        format.html { redirect_to entry_question_path(@entry, @question) }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    flash.now[:notice] = "Question deleted successfully.".html_safe
    respond_to do |format|
      format.html { redirect_to entry_questions_path(@entry) }
      format.turbo_stream
    end
  end

  private

def set_entry
  @entry = current_user.entries.find(params[:entry_id])
end

def set_question
  @question = @entry.questions.find(params[:id])
end

 def question_params
  params.require(:question).permit(:text, :description)
end
end

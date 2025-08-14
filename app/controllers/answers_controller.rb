class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry
  before_action :set_question
  before_action :set_answer, only: %i[edit update destroy]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      flash.now[:notice] = "Answer created successfully."
      respond_to do |format|
        format.html { redirect_to entry_question_path(@entry, @question) }
        format.turbo_stream {}
      end
    else
      flash.now[:alert] = "Failed to create answer."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      flash.now[:notice] = "Answer updated successfully."
      respond_to do |format|
        format.html { redirect_to entry_question_path(@entry, @question) }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    flash.now[:notice] = "Answer deleted successfully."
    respond_to do |format|
      format.html { redirect_to entry_question_path(@entry, @question) }
      format.turbo_stream
    end
  end

  private

  def set_entry
    @entry = current_user.entries.find(params[:entry_id])
  end

  def set_question
    @question = @entry.questions.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:answer_text, :correct) 
  end
end

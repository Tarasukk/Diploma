module System
  class AnswersController < ApplicationController
    def create
      @question = Question.find(params[:question_id])
      @answer = @question.answers.new(answer_params)

      if @answer.save
        redirect_to system_quiz_path(@question.test), notice: "Відповідь додана"
      else
        redirect_to system_quiz_path(@question.test), alert: "Помилка при додаванні відповіді"
      end
    end

    private

    def answer_params
      params.require(:answer).permit(:content, :correct)
    end
  end
end

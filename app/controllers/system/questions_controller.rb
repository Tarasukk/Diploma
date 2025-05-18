module System
  class QuestionsController < ApplicationController
    def create
      @test = Test.find(params[:quiz_id])
      @question = @test.questions.new(question_params)

      if @question.save
        redirect_to system_quiz_path(@test), notice: 'Питання додано'
      else
        redirect_to system_quiz_path(@test), alert: 'Помилка при додаванні'
      end
    end

    def destroy
      question = Question.find(params[:id])
      test = question.test
      question.destroy

      redirect_to system_quiz_path(test), notice: 'Питання видалено'
    end

    private

    def question_params
      params.require(:question).permit(:content)
    end
  end
end

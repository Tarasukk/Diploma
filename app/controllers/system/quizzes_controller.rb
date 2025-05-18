module System
  class QuizzesController < ApplicationController
    def index
      @tests = Test.all
      @test = Test.new
    end

    def create
      @test = Test.new(test_params)
      if @test.save
        redirect_to system_quizzes_path, notice: 'Тест створено'
      else
        @tests = Test.all
        render :index, alert: 'Помилка при створенні'
      end
    end

    def show
      @test = Test.includes(questions: :answers).find(params[:id])
      @question = @test.questions.new
      @answer = Answer.new
    end

    private
    def test_params
      params.require(:test).permit(:title, :description)
    end
  end
end

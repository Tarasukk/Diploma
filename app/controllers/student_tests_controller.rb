class StudentTestsController < ApplicationController
  def show
    @student_test = StudentTest.find(params[:id])
    if @student_test.completed?
      redirect_to results_student_test_path(@student_test)
    end
    @questions = @student_test.test.questions
    @question = @student_test.current_question || @student_test.test.questions.first
    @student_answer = @student_test.student_answers.find_by(question: @question)
    @answered_question_ids = @student_test.student_answers.pluck(:question_id)
    @last_question = @questions.order(:id).last
  end

  def answer
    @student_test = StudentTest.find(params[:id])

    question = Question.find(params[:question_id])
    answer = Answer.find(params[:answer_id])

    student_answer = StudentAnswer.find_or_initialize_by(
      student_test: @student_test,
      question: question
    )
    student_answer.answer = answer
    student_answer.save!

    next_question = @student_test.test.questions.where('id > ?', question.id).first

    if next_question
      @student_test.update!(current_question: next_question)
      redirect_to student_test_path(@student_test)
    else
      @student_test.update!(completed: true)
      redirect_to results_student_test_path(@student_test)
    end
  end

  def switch_question
    @student_test = StudentTest.find(params[:id])
    question = @student_test.test.questions.find(params[:question_id])

    @student_test.update!(current_question_id: question.id)

    redirect_to student_test_path(@student_test)
  end

  def results
    @student_test = StudentTest.find(params[:id])

    result = StudentTests::EvaluateTestCommand.new(@student_test).call
    @score = result[:score]
    @total = result[:total]
    @evaluated_results = result[:results]

    @material = @student_test.test.course_material
    if StudentService.get_student_submission(current_user,  @material).blank?
      CourseMaterialSubmission.create!(
        user: current_user,
        course_material: @material,
        status: 'graded',
        grade: @score,
        graded_at: Time.now
      )
    end
  end
end

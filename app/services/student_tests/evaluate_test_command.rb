# app/services/student_tests/evaluate_test_command.rb
module StudentTests
  class EvaluateTestCommand
    def initialize(student_test)
      @student_test = student_test
      @questions = student_test.test.questions.includes(:answers)
      @student_answers = student_test.student_answers.index_by(&:question_id)
    end

    def call
      results = @questions.map do |question|
        student_answer = @student_answers[question.id]
        correct_answer = question.answers.find(&:correct?)

        {
          question: question,
          student_answer: student_answer&.answer,
          correct_answer: correct_answer,
          correct: student_answer&.answer_id == correct_answer.id
        }
      end

      score = results.count { |r| r[:correct] }
      total = results.size

      {
        score: score,
        total: total,
        results: results
      }
    end
  end
end

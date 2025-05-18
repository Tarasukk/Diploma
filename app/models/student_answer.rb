class StudentAnswer < ApplicationRecord
  belongs_to :student_test
  belongs_to :question
  belongs_to :answer
end

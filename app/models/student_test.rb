class StudentTest < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true
  has_many :student_answers, dependent: :destroy
end

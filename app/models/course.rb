class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User'

  has_many :course_enrollments, dependent: :destroy
  has_many :students, through: :course_enrollments, source: :user

  has_one_attached :preview_file
end

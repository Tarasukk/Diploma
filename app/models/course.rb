class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User'

  has_many :course_enrollments, dependent: :destroy
  has_many :students, through: :course_enrollments, source: :user
  has_many :course_sections, dependent: :destroy
  has_many :schedule_events

  has_one_attached :preview_file
  has_one_attached :avatar

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at department description id teacher_id title updated_at]
  end
end

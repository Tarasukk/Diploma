class ScheduleEvent < ApplicationRecord
  belongs_to :student_group
  belongs_to :course, optional: true

  validates :date, :title, presence: true
end

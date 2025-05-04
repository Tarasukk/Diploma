class ScheduleEvent < ApplicationRecord
  belongs_to :student_group
  belongs_to :course

  validates :date, :title, presence: true
end

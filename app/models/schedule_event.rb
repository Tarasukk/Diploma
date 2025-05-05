class ScheduleEvent < ApplicationRecord
  belongs_to :student_group, optional: true
  belongs_to :course, optional: true
  belongs_to :user, optional: true

  validates :date, :title, presence: true
end

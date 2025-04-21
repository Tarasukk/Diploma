class SubmissionComment < ApplicationRecord
  belongs_to :course_material_submission
  belongs_to :user

  validates :content, presence: true
end

class CourseMaterialSubmission < ApplicationRecord
  belongs_to :user
  belongs_to :course_material

  has_one_attached :file
  has_many :submission_comments, dependent: :destroy

  enum status: {
    not_submitted: 'not_submitted',
    submitted: 'submitted'
  }

  validates :user_id, :course_material_id, :file, presence: true
end

class CourseMaterialSubmission < ApplicationRecord
  belongs_to :user
  belongs_to :course_material

  has_one_attached :file
  has_many :submission_comments, dependent: :destroy

  enum status: {
    pending: 'pending',
    graded: 'graded'
  }

  validates :user_id, :course_material_id, :file, presence: true


  def self.ransackable_attributes(auth_object = nil)
    %w[id status grade evaluated submitted_at created_at updated_at user_id course_material_id]
  end

  def self.ransackable_associations(_ = nil)
    %w[user course_material course_material.course user.student_group]
  end
end

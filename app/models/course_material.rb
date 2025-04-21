class CourseMaterial < ApplicationRecord
  belongs_to :course_section

  has_many :course_material_submissions, dependent: :destroy
  has_many_attached :files

  attribute :submittable, :boolean, default: false
  enum material_type: {
    lecture: 'lecture',
    lab: 'lab'
  }


  validates :title, :material_type, presence: true
  validates :course_section_id, presence: true

  delegate :course, to: :course_section
end

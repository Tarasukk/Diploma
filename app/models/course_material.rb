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

  def self.ransackable_attributes(auth_object = nil)
    %w[content course_section_id created_at deadline id material_type max_grade submittable title updated_at]
  end


  def self.ransackable_associations(auth_object = nil)
    %w[course_material_submissions course_section]
  end
end

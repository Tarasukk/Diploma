class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'User'

  has_many :course_enrollments, dependent: :destroy
  has_many :students, through: :course_enrollments, source: :user
  has_many :course_sections, dependent: :destroy
  has_many :schedule_events
  has_many :course_materials, through: :course_sections

  has_one_attached :preview_file
  has_one_attached :avatar

  def completion_percentage_for(user)
    required_materials = course_materials.where('submittable = ? OR test_id IS NOT NULL', true)

    return 0 if required_materials.empty?

    submitted_ids = CourseMaterialSubmission
      .where(user: user, course_material_id: required_materials.select(:id))
      .distinct
      .pluck(:course_material_id)

    ((submitted_ids.count.to_f / required_materials.count) * 100).round
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at department description id teacher_id title updated_at]
  end
end

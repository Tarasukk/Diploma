class CourseSection < ApplicationRecord
  belongs_to :course

  has_many :course_materials, dependent: :destroy

  validates :title, presence: true
  validates :position, uniqueness: { scope: :course_id }

  default_scope { order(:position) }

  def self.ransackable_attributes(auth_object = nil)
    %w[course_id created_at id position title updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[course course_materials]
  end
end

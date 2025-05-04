class CourseSection < ApplicationRecord
  belongs_to :course

  has_many :course_materials, dependent: :destroy

  validates :title, presence: true
  validates :position, uniqueness: { scope: :course_id }

  default_scope { order(:position) }
end

class CourseSection < ApplicationRecord
  belongs_to :course

  has_many :course_materials, dependent: :destroy

  validates :title, presence: true

  default_scope { order(:position) }
end

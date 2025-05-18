class Test < ApplicationRecord
  has_many :questions
  has_one :course_material, dependent: :nullify

  accepts_nested_attributes_for :questions
end

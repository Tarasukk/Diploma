class StudentGroup < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :schedule_events

  validates :name, presence: true
end

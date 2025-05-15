class StudentGroup < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :schedule_events

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id name updated_at]
  end
end

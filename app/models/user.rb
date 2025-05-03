class User < ApplicationRecord
  enum role: { user: 'user', admin: 'admin' }, _default: 'user'

  has_many :course_enrollments
  has_many :enrolled_courses, through: :course_enrollments, source: :course
  has_many :teaching_courses, class_name: 'Course', foreign_key: 'teacher_id'
  has_many :course_material_submissions, dependent: :destroy

  belongs_to :student_group, optional: true

  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    user ||= User.create(
      email: data['email'],
      password: Devise.friendly_token[0, 20],
      provider: access_token.provider,
      uid: access_token.uid
    )
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at email encrypted_password id id_value name phone_number provider remember_created_at reset_password_sent_at reset_password_token role student_group_id uid updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["avatar_attachment", "avatar_blob", "course_enrollments", "course_material_submissions", "enrolled_courses", "student_group", "teaching_courses"]
  end
end

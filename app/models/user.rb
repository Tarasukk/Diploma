class User < ApplicationRecord
  enum role: { user: 'user', admin: 'admin' }, _default: 'user'

  has_many :course_enrollments
  has_many :enrolled_courses, through: :course_enrollments, source: :course
  has_many :teaching_courses, class_name: 'Course', foreign_key: 'teacher_id'
  has_many :course_material_submissions, dependent: :destroy

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
end

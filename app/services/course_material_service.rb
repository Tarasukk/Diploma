module CourseMaterialService
  extend ActionView::Helpers::DateHelper
  module_function

  def student_submit_assignment?(student, course_material)
    submission = StudentService.get_student_submission(student, course_material)

    submission.present?
  end

  def last_time_assignment_updated(student, course_material)
    submission = StudentService.get_student_submission(student, course_material)
    return '-' unless submission&.updated_at.present?

    I18n.l(submission.updated_at, format: :full_uk_date, locale: :uk)
  end

  def submission_delay_text(student, course_material)
    deadline = course_material.deadline
    return '-' if deadline.blank?

    submission = StudentService.get_student_submission(student, course_material)

    if submission.blank?
      "Здати до #{I18n.l(deadline, format: '%-d %B %Y %H:%M')}"
    else
      diff = submission.updated_at - deadline

      if diff < 0
        distance = HelperService.human_time_difference(submission.updated_at, deadline)
        "Здано на #{distance} раніше дедлайну"
      else
        distance = HelperService.human_time_difference(deadline, submission.updated_at)
        "Здано із запізненням на #{distance}"
      end
    end
  end

  def submission_file_info(student, course_material)
    submission = StudentService.get_student_submission(student, course_material)
    return nil unless submission&.file&.attached?

    {
      url: Rails.application.routes.url_helpers.rails_blob_url(submission.file, only_path: true),
      filename: submission.file.filename.to_s,
      submitted_at: submission.submitted_at
    }
  end
end

module CourseMaterialsHelper
  def submission_bg_class(student, course_material)
    deadline = course_material.deadline
    return '' if deadline.blank?

    submission = student.course_material_submissions.find_by(course_material: course_material)
    return '' if submission.blank?

    diff = submission.updated_at - deadline
    diff < 0 ? 'bg-green-100' : 'bg-red-100'
  end

end

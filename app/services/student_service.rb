module StudentService
  module_function

  def get_student_submission(student, course_material)
    student.course_material_submissions.find_by(course_material: course_material)
  end

  def get_who_grade(course_material_submission)
    return false if course_material_submission.blank?
    return false if course_material_submission.graded_by_id.blank?

    User.find_by(
      id: course_material_submission.graded_by_id
    ).name
  end
end

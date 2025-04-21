module StudentService
  module_function

  def get_student_submission(student, course_material)
    student.course_material_submissions.find_by(course_material: course_material)
  end
end

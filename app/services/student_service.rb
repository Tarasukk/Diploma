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

  def create_remainder_for_course_materials(student, course)
    course.course_sections.includes(:course_materials).each do |section|
      section.course_materials.where(submittable: true).each do |material|
        next if material.course_material_submissions.exists?(user_id: student.id)
        next if material.deadline.blank?

        ScheduleEvent.create!(
          title: "Нагадування - здати #{material.title}",
          date: material.deadline,
          student_group_id: student.student_group_id,
          course_id: course.id,
          user_id: student.id,
          course_material_id: material.id
        )
      end
    end
  end
end

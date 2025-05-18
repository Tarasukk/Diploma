class CoursesController < ApplicationController
  before_action :assign_random_group_if_none, only: [:index]

  def index
    @enrolled_courses = current_user.enrolled_courses
    @available_courses = Course.where.not(id: @enrolled_courses.pluck(:id))
  end

  def show
    @course = Course.find(params[:id])
    @student_group = StudentGroup.last
    @events = @student_group.schedule_events.group_by(&:date)
    unless current_user.enrolled_courses.include?(@course) || current_user.teaching_courses.include?(@course)
      redirect_to courses_path, alert: 'Ви не маєте доступу до цього курсу.'
    end
  end

  def gradebook
    @course = Course.find(params[:id])
    @materials = CourseMaterial.joins(course_section: :course)
      .where(course_sections: { course_id: @course.id })
      .where('course_materials.submittable = ? OR course_materials.test_id IS NOT NULL', true)
    @submissions_by_material_id = current_user.course_material_submissions.joins(course_material: { course_section: :course })
      .where(course_sections: { course_id: @course.id })
      .index_by(&:course_material_id)

    @total_grade = 0
    @max_grade = 0

    @materials.each do |material|
      submission = @submissions_by_material_id[material.id]
      @total_grade += submission&.grade.to_f
      @max_grade += material.max_grade.to_f
    end
  end

  def enrolled_students
    @course = Course.find(params[:id])
    @same_group_students = @course.students.where(student_group_id: current_user.student_group_id)
  end

  def enroll
    course = Course.find(params[:id])
    unless current_user.enrolled_courses.include?(course)
      current_user.enrolled_courses << course

      StudentService.create_remainder_for_course_materials(current_user, course)
      flash[:notice] = 'Ви успішно записалися на курс.'
    else
      flash[:alert] = 'Ви вже записані на цей курс.'
    end

    redirect_to courses_path
  end

  private

  def assign_random_group_if_none
    return if current_user.student_group.present?

    random_group = StudentGroup.order("RANDOM()").first
    current_user.update(student_group: random_group) if random_group
  end
end

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

  def enroll
    course = Course.find(params[:id])
    unless current_user.enrolled_courses.include?(course)
      current_user.enrolled_courses << course
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

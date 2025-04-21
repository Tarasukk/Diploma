class CourseSectionsController < ApplicationController
  before_action :set_course
  before_action :authorize_teacher!

  def create
    @course_section = CourseSection.build(title: params[:title], course: @course)
    if @course_section.save
      flash[:notice] = 'Секція створена успішно'
      redirect_back fallback_location: course_path(@course)
    else
      flash[:alert] = 'Не вдалося створити секцію.'
      redirect_back fallback_location: course_path(@course)
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def authorize_teacher!
    unless current_user == @course.teacher
      flash[:alert] = 'У вас немає прав доступу.'
      redirect_to root_path
    end
  end
end

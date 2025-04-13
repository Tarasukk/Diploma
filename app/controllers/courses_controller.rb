class CoursesController < ApplicationController
  def index
    @courses = current_user.enrolled_courses
  end

  def show
    @course = Course.find(params[:id])

    unless current_user.enrolled_courses.include?(@course) || current_user.teaching_courses.include?(@course)
      redirect_to courses_path, alert: 'Ви не маєте доступу до цього курсу.'
    end
  end
end

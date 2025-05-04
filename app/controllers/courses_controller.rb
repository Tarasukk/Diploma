class CoursesController < ApplicationController
  def index
    @courses = current_user.enrolled_courses
  end

  def show
    @course = Course.find(params[:id])
    @student_group = StudentGroup.last
    @events = @student_group.schedule_events.group_by(&:date)
    unless current_user.enrolled_courses.include?(@course) || current_user.teaching_courses.include?(@course)
      redirect_to courses_path, alert: 'Ви не маєте доступу до цього курсу.'
    end
  end
end

# app/controllers/system/courses_controller.rb
module System
  class CoursesController < ApplicationController
    def index
      @courses = Course.where(teacher_id: current_user.id)
    end

    def update
      course = Course.find(params[:id])

      if course.update(course_params)
        flash[:notice] = "Курс оновлено"
      else
        flash[:alert] = course.errors.full_messages.join(', ')
      end

      redirect_to system_course_builder_courses_path
    end

    def new
      @course = Course.new
    end

    def create_course
      course = Course.new(course_params.merge(teacher_id: current_user.id))

      if course.save
        flash[:notice] = 'Курс успішно створено.'
      else
        flash[:alert] = course.errors.full_messages.join(', ')
      end

      redirect_back fallback_location: root_path
    end

    def create_section
      section = CourseSection.new(section_params)

      if section.save
        flash[:notice] = 'Cекція успішно створено.'
      else
        flash[:alert] = section.errors.full_messages.join(', ')
      end

      redirect_back fallback_location: root_path
    end

    def create_material
      material = CourseMaterial.new(material_params)

      if material.save
        flash[:notice] = 'Матеріал успішно створено.'
      else
        flash[:alert] = section.errors.full_messages.join(', ')
      end

      redirect_back fallback_location: root_path
    end

    def create_event
      event = ScheduleEvent.new(schedule_event_params)

      if event.save
        flash[:notice] = 'Подію успішно створено.'
      else
        flash[:alert] = event.errors.full_messages.join(', ')
      end

      redirect_back fallback_location: root_path
    end

    private

    def course_params
      params.require(:course).permit(:avatar, :title, :description, :department)
    end

    def schedule_event_params
      params.require(:schedule_event).permit(:title, :date, :student_group_id, :course_id, :user_id)
    end

    def section_params
      params.require(:course_section).permit(:title, :course_id, :position)
    end

    def material_params
      params.require(:course_material).permit(
        :title,
        :course_section_id,
        :test_id,
        :content,
        :material_type,
        :submittable,
        :topic,
        :assignment_number,
        :max_grade,
        :deadline,
        files: []
      )
    end
  end
end

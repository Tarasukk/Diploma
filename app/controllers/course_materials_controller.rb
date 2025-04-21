class CourseMaterialsController < ApplicationController
  before_action :set_course_section, except: :show
  before_action :authorize_teacher!

  def new
    @course_material = @course_section.course_materials.build
  end

  def create

    @course_material = @course_section.course_materials.build(course_material_params)
    if @course_material.save
      redirect_to course_path(@course_section.course), notice: 'Матеріал успішно створено'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @course_material = CourseMaterial.find(params[:id])
    @current_course = @course_material.course
    @submitted = CourseMaterialService.student_submit_assignment?(current_user, @course_material)
    @file_info = CourseMaterialService.submission_file_info(current_user, @course_material)
    @updated_at = CourseMaterialService.last_time_assignment_updated(current_user, @course_material)
    @comments = StudentService.get_student_submission(current_user, @course_material).submission_comments
  end

  private

  def set_course_section
    @course_section = CourseSection.find(params[:course_section_id])
  end

  def authorize_teacher! #todo
    # unless current_user == @course_section.course.teacher
    #   redirect_to root_path, alert: 'У вас немає прав доступу'
    # end
  end

  def course_material_params
    params.permit(
      :title,
      :content,
      :material_type,
      :submittable,
      files: []
    )
  end
end

module System
  class CourseMaterialsController < ApplicationController
    def new
      @course_material = CourseMaterial.new
    end

    def create
      @course_material = @course_section.course_materials.build(course_material_params)
      if @course_material.save
        redirect_to course_path(@course_section.course), notice: 'Матеріал успішно створено'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def set_course_section
    @course_section = CourseSection.find(params[:course_section_id])
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


class CourseMaterialSubmissionsController < ApplicationController
  def create
    @submission = current_user.course_material_submissions.new(submission_params)
    @submission.submitted_at = Time.current

    if @submission.file.attached?
      if @submission.save
        destroy_event
        flash[:notice] = 'Роботу успішно надіслано.'
      else
        flash[:alert] = 'Помилка при збереженні файлу.'
      end
    else
      flash[:alert] = 'Файл не обрано.'
    end

    redirect_back fallback_location: root_path
  end

  private

  def destroy_event
    ScheduleEvent.where(
      user_id: current_user.id,
      course_material_id: @submission.course_material_id
    ).destroy_all
  end

  def submission_params
    params.require(:course_material_submission).permit(:file, :course_material_id)
  end
end

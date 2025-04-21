class CourseMaterialSubmissionsController < ApplicationController
  def create
    @submission = current_user.course_material_submissions.new(submission_params)
    @submission.submitted_at = Time.current

    if @submission.file.attached?
      if @submission.save
        redirect_back fallback_location: root_path, notice: 'Роботу успішно надіслано.'
      else
        redirect_back fallback_location: root_path, alert: 'Помилка при збереженні файлу.'
      end
    else
      redirect_back fallback_location: root_path, alert: 'Файл не обрано.'
    end
  end

  private

  def submission_params
    params.require(:course_material_submission).permit(:file, :course_material_id)
  end
end

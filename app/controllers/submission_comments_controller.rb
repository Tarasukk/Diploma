class SubmissionCommentsController < ApplicationController
  def create
    course_material = CourseMaterial.find(params[:course_material_id])

    submission = StudentService.get_student_submission(current_user, course_material)
    comment = submission.submission_comments.new(content: params[:content], user: current_user)

    if comment.save
      flash[:notice] = 'Коментар додано.'
    else
      flash[:alert] = 'Не вдалося створити коментар.'
    end

    redirect_back fallback_location: root_path
  end

  def destroy
    comment = SubmissionComment.find(params[:id])

    if comment.user == current_user
      comment.destroy
      flash[:notice] = 'Коментар видалено.'
    else
      flash[:alert] = 'Ви не можете видалити цей коментар.'
    end

    redirect_back fallback_location: root_path
  end
end

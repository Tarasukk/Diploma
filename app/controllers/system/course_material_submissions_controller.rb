module System
  class CourseMaterialSubmissionsController < ApplicationController
    def index
      @q = CourseMaterialSubmission.ransack(params[:q])
      @pagy, @submissions = pagy(
        @q.result.includes(:user, :course_material).order(created_at: :desc)
      )
    end

    def show
      @submission = CourseMaterialSubmission.find(params[:id])
    end

    def grade
      submission = CourseMaterialSubmission.find(params[:id])

      submission.grade = params[:grade]
      submission.graded_by_id = current_user.id
      submission.graded_at = Time.now

      if submission.save
        submission.update(status: 'graded')
        flash[:notice] = "Оцінка '#{params[:grade]}' зарахована"
      else
        flash[:alert] = submission.errors.full_messages.join(', ')
      end

      redirect_back fallback_location: root_path
    end

    private

    def require_admin!
      #todo
    end
  end
end

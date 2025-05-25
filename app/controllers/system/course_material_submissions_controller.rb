module System
  class CourseMaterialSubmissionsController < ApplicationController
    def index
      @q = CourseMaterialSubmission.ransack(params[:q])
      @pagy, @submissions = pagy(
        @q.result.includes(user: :student_group, course_material: { course_section: :course }).order(created_at: :desc)
      )
    end

    def show
      @submission = CourseMaterialSubmission.find(params[:id])
      @material = @submission.course_material
      @comments = @submission.submission_comments.order(created_at: :asc)

      if params[:check_plagiarism] == 'true'
        raw_results = PlagiarismDetectionService.call(@submission)
        @similar_submissions = CourseMaterialSubmission.where(id: raw_results.map { |r| r[:id] }).index_by(&:id)

        @similarity_results = raw_results.map do |r|
          {
            submission: @similar_submissions[r[:id]],
            similarity: r[:similarity]
          }
        end
      end

      @new_comment = SubmissionComment.new
    end

    def create_comment
      @submission = CourseMaterialSubmission.find(params[:id])
      @comment = @submission.submission_comments.build(comment_params.merge(user: current_user))

      if @comment.save
        redirect_to system_course_material_submission_path(@submission), notice: "Коментар додано"
      else
        @material = @submission.course_material
        @comments = @submission.submission_comments.order(created_at: :asc)
        @new_comment = @comment
        render :show
      end
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

    def comment_params
      params.require(:submission_comment).permit(:content)
    end

    def require_admin!
      #todo
    end
  end
end

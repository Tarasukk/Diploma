class CourseMaterialsController < ApplicationController
  before_action :authorize_teacher!

  def update_file
    @course_material = CourseMaterial.find(params[:id])
    submission = StudentService.get_student_submission(current_user, @course_material)

    if params[:file].present?
      submission.file.purge if submission.file.attached?
      submission.file.attach(params[:file])
      submission.submitted_at = Time.current
      submission.save

      flash[:notice] = 'Файл оновлено.'
    else
      flash[:alert] = 'Файл не обрано.'
    end
    redirect_back fallback_location: root_path
  end

  def remove_file
    @course_material = CourseMaterial.find(params[:id])
    submission = StudentService.get_student_submission(current_user, @course_material)

    if submission&.file&.attached?
      submission.file.purge
      submission.save
      flash[:notice] = 'Файл видалено.'
    else
      flash[:alert] = 'Файл не знайдено або вже видалений.'
    end

    redirect_back fallback_location: root_path
  end

  def show
    @course_material = CourseMaterial.find(params[:id])
    @current_course = @course_material.course
    @submitted = CourseMaterialService.student_submit_assignment?(current_user, @course_material)
    @file_info = CourseMaterialService.submission_file_info(current_user, @course_material)
    @updated_at = CourseMaterialService.last_time_assignment_updated(current_user, @course_material)
    @comments = StudentService.get_student_submission(current_user, @course_material)&.submission_comments


    @student_submition = StudentService.get_student_submission(current_user, @course_material)
    @teacher = StudentService.get_who_grade(@student_submition)
  end

  def start_quiz
    material = CourseMaterial.find(params[:id])
    test = material.test

    student_test = StudentTest.find_by(user: current_user, test: test)

    unless student_test
      student_test = StudentTest.create!(
        user: current_user,
        test: test,
        current_question: test.questions.order(:id).first
      )
    end

    redirect_to student_test_path(student_test)
  end

  private

  def authorize_teacher! #todo
    # unless current_user == @course_section.course.teacher
    #   redirect_to root_path, alert: 'У вас немає прав доступу'
    # end
  end
end

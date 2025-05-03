class ChangeDefaultStatusInCourseMaterialSubmissions < ActiveRecord::Migration[7.2]
  def change
    change_column_default :course_material_submissions, :status, 'pending'
  end
end

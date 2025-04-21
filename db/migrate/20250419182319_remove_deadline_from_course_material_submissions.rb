class RemoveDeadlineFromCourseMaterialSubmissions < ActiveRecord::Migration[7.2]
  def change
    remove_column :course_material_submissions, :deadline, :datetime
  end
end

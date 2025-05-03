class AddGradeToCourseMaterialSubmissions < ActiveRecord::Migration[7.2]
  def change
    add_column :course_material_submissions, :grade, :integer
  end
end

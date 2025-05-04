class AddGradedByToCourseMaterialSubmissions < ActiveRecord::Migration[7.2]
  def change
    add_reference :course_material_submissions, :graded_by, foreign_key: { to_table: :users }
  end
end

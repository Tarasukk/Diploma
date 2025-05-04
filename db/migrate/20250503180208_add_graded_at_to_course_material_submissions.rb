class AddGradedAtToCourseMaterialSubmissions < ActiveRecord::Migration[7.2]
  def change
    add_column :course_material_submissions, :graded_at, :datetime
  end
end

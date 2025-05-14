class AddAssignmentNumberToCourseMaterials < ActiveRecord::Migration[7.2]
  def change
    add_column :course_materials, :assignment_number, :integer
  end
end

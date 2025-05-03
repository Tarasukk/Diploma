class AddMaxGradeToCourseMaterials < ActiveRecord::Migration[7.2]
  def change
    add_column :course_materials, :max_grade, :integer
  end
end

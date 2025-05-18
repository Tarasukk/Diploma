class AddTestToCourseMaterials < ActiveRecord::Migration[7.0]
  def change
    add_reference :course_materials, :test, foreign_key: true, null: true
  end
end

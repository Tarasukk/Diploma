class AddSubmittableToCourseMaterials < ActiveRecord::Migration[7.2]
  def change
    add_column :course_materials, :submittable, :boolean
  end
end

class CreateCourseMaterials < ActiveRecord::Migration[7.2]
  def change
    create_table :course_materials do |t|
      t.string :title
      t.text :content
      t.string :material_type
      t.references :course_section, null: false, foreign_key: true

      t.timestamps
    end
  end
end

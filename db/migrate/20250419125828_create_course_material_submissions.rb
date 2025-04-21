class CreateCourseMaterialSubmissions < ActiveRecord::Migration[7.2]
  def change
    create_table :course_material_submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course_material, null: false, foreign_key: true
      t.string :status
      t.boolean :evaluated
      t.datetime :submitted_at
      t.datetime :deadline

      t.timestamps
    end
  end
end

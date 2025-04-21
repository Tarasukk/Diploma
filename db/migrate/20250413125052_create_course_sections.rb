class CreateCourseSections < ActiveRecord::Migration[7.2]
  def change
    create_table :course_sections do |t|
      t.string :title
      t.references :course, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end

class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.string :department

      t.timestamps
    end
  end
end

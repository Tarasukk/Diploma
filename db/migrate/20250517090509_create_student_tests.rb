class CreateStudentTests < ActiveRecord::Migration[7.2]
  def change
    create_table :student_tests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.references :current_question, foreign_key: { to_table: :questions }

      t.boolean :completed

      t.timestamps
    end
  end
end

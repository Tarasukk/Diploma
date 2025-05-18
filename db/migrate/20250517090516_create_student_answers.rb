class CreateStudentAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :student_answers do |t|
      t.references :student_test, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end

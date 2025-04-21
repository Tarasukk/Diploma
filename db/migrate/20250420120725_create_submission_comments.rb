class CreateSubmissionComments < ActiveRecord::Migration[7.2]
  def change
    create_table :submission_comments do |t|
      t.references :course_material_submission, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end

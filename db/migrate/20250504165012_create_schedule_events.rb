class CreateScheduleEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :schedule_events do |t|
      t.string :title
      t.date :date
      t.references :student_group, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class AddCourseMaterialToScheduleEvents < ActiveRecord::Migration[7.2]
  def change
    add_reference :schedule_events, :course_material, foreign_key: true
  end
end

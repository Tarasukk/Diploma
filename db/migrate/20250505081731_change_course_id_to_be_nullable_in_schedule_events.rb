class ChangeCourseIdToBeNullableInScheduleEvents < ActiveRecord::Migration[7.2]
  def change
    change_column_null :schedule_events, :course_id, true
  end
end

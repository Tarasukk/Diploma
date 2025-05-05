class MakeStudentGroupOptionalInScheduleEvents < ActiveRecord::Migration[7.2]
  def change
    change_column_null :schedule_events, :student_group_id, true
  end
end

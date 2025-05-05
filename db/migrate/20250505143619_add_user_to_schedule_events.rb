class AddUserToScheduleEvents < ActiveRecord::Migration[7.2]
  def change
    add_reference :schedule_events, :user, foreign_key: true, null: true
  end
end

class AddStudentGroupToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :student_group, foreign_key: true
  end
end

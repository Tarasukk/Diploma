# db/migrate/XXXXXXXXXXXXXX_add_deadline_to_course_materials.rb
class AddDeadlineToCourseMaterials < ActiveRecord::Migration[7.2]
  def change
    add_column :course_materials, :deadline, :datetime
  end
end

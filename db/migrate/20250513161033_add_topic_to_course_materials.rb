class AddTopicToCourseMaterials < ActiveRecord::Migration[7.2]
  def change
    add_column :course_materials, :topic, :string
  end
end

class AddAutoGenerateTitlePageToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :auto_generate_title_page, :boolean, default: true
  end
end

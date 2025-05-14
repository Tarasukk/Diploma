class AddDisableEmailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :disable_emails, :boolean
  end
end

class AddNameAndPhoneNumberToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_column :users, :phone_number, :string
  end
end

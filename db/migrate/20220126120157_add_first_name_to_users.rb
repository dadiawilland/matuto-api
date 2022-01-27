class AddFirstNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :contact_number, :string
    add_column :users, :user_status, :boolean
    add_column :users, :date_graduated, :datetime
  end
end

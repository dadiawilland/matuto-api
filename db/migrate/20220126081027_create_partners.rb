class CreatePartners < ActiveRecord::Migration[7.0]
  def change
    create_table :partners do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.boolean :business_type, null: false
      t.string :industry
      t.boolean :application_status, null: false
      t.string :contact_number
      t.string :email, null: false

      t.timestamps null: false
    end
    add_index :partners, :name, unique: true
  end
end

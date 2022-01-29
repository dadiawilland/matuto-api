class CreatePaymentInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_infos do |t|
      t.integer :payment_type, :limit => 2, null: false
      t.string :name, null: false
      t.integer :number, null: false
      t.integer :cvv, :limit => 3, null: false
      t.datetime :date_expiration, null: false
      t.integer  :user_id

      t.timestamps
    end
    add_foreign_key(
      :payment_infos,
      :users
    )
  end
end

class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :claimer_id
      t.string :phone_number
      t.string :house_dorm
      t.string :room
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.time :expiration
      t.boolean :paid
      t.integer :restaurant_id
      t.text :description
      t.integer :cost
      t.integer :tip
      t.integer :total
      t.string :payment_type
      t.timestamps

    end
    add_index :orders, [:user_id, :claimer_id]
  end
end

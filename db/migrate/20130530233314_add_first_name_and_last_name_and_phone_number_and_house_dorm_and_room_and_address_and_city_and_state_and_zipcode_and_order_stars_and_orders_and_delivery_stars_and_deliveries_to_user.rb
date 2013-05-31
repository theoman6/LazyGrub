class AddFirstNameAndLastNameAndPhoneNumberAndHouseDormAndRoomAndAddressAndCityAndStateAndZipcodeAndOrderStarsAndOrdersAndDeliveryStarsAndDeliveriesToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :house_dorm, :string
    add_column :users, :room, :string
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zipcode, :string
    add_column :users, :order_stars, :integer
    add_column :users, :orders, :integer
    add_column :users, :delivery_stars, :integer
    add_column :users, :deliveries, :integer
  end
end

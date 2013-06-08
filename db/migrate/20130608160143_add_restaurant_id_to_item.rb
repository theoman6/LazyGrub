class AddRestaurantIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :restaurant_id, :integer
  end
end

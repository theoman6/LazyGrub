class RemoveLocationFromRestaurants < ActiveRecord::Migration
  def up
    add_column :restaurants, :city, :string
    add_column :restaurants, :state, :string
    add_column :restaurants, :zip, :string
  end

  def down
  end
end

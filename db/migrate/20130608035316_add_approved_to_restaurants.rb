class AddApprovedToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :approved, :boolean
  end
end

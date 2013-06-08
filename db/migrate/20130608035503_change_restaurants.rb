class ChangeRestaurants < ActiveRecord::Migration
  def up
    remove_column :restaurants, :location
  end

  def down
  end
end

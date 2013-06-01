class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.integer :id
      t.string :location

      t.timestamps
    end
  end
end

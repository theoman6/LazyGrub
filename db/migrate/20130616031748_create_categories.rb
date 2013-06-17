class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :restaurant_id
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end

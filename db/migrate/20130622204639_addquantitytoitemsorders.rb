class Addquantitytoitemsorders < ActiveRecord::Migration
  def change 
    add_column :items_orders, :quantity, :integer
  end
end

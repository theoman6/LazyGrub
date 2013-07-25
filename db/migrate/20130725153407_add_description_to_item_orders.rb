class AddDescriptionToItemOrders < ActiveRecord::Migration
  def change
    add_column :items_orders, :description, :string
  end
end

class Renameproductidtoitemid < ActiveRecord::Migration
  def up
    rename_column :choices, :product_id, :item_id
  end

  def down
  end
end

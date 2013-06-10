class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :orders, :items, :item_ids
  end

  def down
  end
end

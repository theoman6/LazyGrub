class AddIdToOrder < ActiveRecord::Migration
  def change
  	add_column :choices, :id, :primary_key
  end
end

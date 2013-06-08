class AddClearanceToUser < ActiveRecord::Migration
  def change
    add_column :users, :clearance, :integer
  end
end

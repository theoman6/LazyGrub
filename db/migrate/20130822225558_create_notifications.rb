class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :description
      t.string :body
      t.timestamp :claimed_at

      t.timestamps
    end
  end
end

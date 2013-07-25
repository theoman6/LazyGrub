class CreateChoices < ActiveRecord::Migration
	def self.up
	  create_table 'choices', :id => false do |t|
	    t.column :order_id, :integer
	    t.column :product_id, :integer
	    t.column :description, :string
	    t.timestamps
	  end
	end
end

class Item < ActiveRecord::Base
  attr_accessible :cost, :description, :name, :restaurant_id
  belongs_to :restaurant
  has_and_belongs_to_many :orders
end

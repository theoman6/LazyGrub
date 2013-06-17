class Item < ActiveRecord::Base
  attr_accessible :cost, :description, :name, :restaurant_id, :category_id
  belongs_to :restaurant
  belongs_to :category
  has_and_belongs_to_many :orders
end

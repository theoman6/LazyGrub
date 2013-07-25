class Item < ActiveRecord::Base
  attr_accessible :cost, :description, :name, :restaurant_id, :category_id
  belongs_to :restaurant
  belongs_to :category
  has_many :choices
  has_many :orders, :through => :choices
end

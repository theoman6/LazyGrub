class Item < ActiveRecord::Base
  attr_accessible :cost, :description, :name, :restaurant_id
  belongs_to :restaurant
end

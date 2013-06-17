class Category < ActiveRecord::Base
  attr_accessible :id, :name, :restaurant_id

  belongs_to :restaurant
  has_many :items
end

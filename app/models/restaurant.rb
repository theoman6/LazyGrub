class Restaurant < ActiveRecord::Base
  attr_accessible :id, :name, :location
  has_many :orders

end

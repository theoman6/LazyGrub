class Restaurant < ActiveRecord::Base
  attr_accessible :id, :name, :address, :city, :state, :zip, :approved
  has_many :orders
  has_many :items
  has_many :categories
  belongs_to :user

end

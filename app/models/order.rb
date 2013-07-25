class Order < ActiveRecord::Base
  attr_accessible :item_ids, :item_quantities, :claimer_id, :user_id, :phone_number, :house_dorm, :room, :address, :city, :state, :zip, :expiration, :paid, :restaurant_id, :description, :cost, :tip, :total, :payment_type
  validates_presence_of :phone_number, :restaurant_id, :cost, :total
  belongs_to :user
  belongs_to :claimer, class_name: "User"
  belongs_to :restaurant
  has_many :choices
  has_many :items, :through => :choices
  serialize :item_ids
end

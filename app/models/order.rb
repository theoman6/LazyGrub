class Order < ActiveRecord::Base
  attr_accessible :item_ids, :item_quantities, :claimer_id, :user_id, :phone_number, :house_dorm, :room, :address, :city, :state, :zip, :expiration, :paid, :restaurant_id, :description, :cost, :tip, :total, :payment_type
  validates_presence_of :phone_number, :expiration, :restaurant_id, :description, :cost, :tip, :total
  belongs_to :user
  belongs_to :claimer, class_name: "User"
  belongs_to :restaurant
  has_and_belongs_to_many :items
  serialize :item_ids
end

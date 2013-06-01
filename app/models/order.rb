class Order < ActiveRecord::Base
  attr_accessible :claimer_id, :user_id, :phone_number, :house_dorm, :room, :address, :city, :state, :zip, :expiration, :paid, :restaurant_id, :description, :cost, :tip, :total, :payment_type
  validate :some_location
  validates_presence_of :phone_number, :expiration, :restaurant_id, :description, :cost, :tip, :total
  belongs_to :user
  belongs_to :restaurant




  def some_location
    if (([self.house_dorm, self.room].compact.size != 2) && ([self.address, self.city, self.state, self.zip].compact.size != 4)) 
      puts 'boobies'
    end
  end
end

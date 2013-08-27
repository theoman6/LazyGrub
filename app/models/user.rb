class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable, :email_regexp => /^([\w\.%\+\-]+)@([\w\-]+\.)+harvard.edu$/i


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :phone_number, :house_dorm,
    :room, :address, :city, :state, :zipcode, :order_stars, :orders, :delivery_stars, :deliveries
  has_many :orders
  has_many :restaurants
  has_many :notifications
  validates_presence_of :first_name, :last_name, :phone_number

  # attr_accessible :title, :body
  def rating 
    self.deliveries.to_i != 0 ? self.delivery_stars / self.deliveries : 0 
  end 

  def authenticate 
    self[:confirmed_at] = Time.now
    self.save
  end
end

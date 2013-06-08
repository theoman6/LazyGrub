class StaticPagesController < ApplicationController
  before_filter :check_restaurant, :only => [:restaurants, :items]
  before_filter :check_has_restaurant, :only => [:items]

  def home
    @order = Order.new
    if user_signed_in? 
      last = current_user.orders.last
      if last.nil?
        @order[:phone_number] = current_user.phone_number
        if  (!current_user.house_dorm.nil? && !current_user.room.nil?)
          @order[:house_dorm] = current_user.house_dorm
          @order[:room] = current_user.room
        else
          @order[:address] = current_user.address
          @order[:city] = current_user.city
          @order[:state] = current_user.state
          @order[:zip] = current_user.zip
        end
      else
        @order = last
        @order[:id] = nil
      end
    end
    @order[:expiration] = 1.hour.from_now
  end
  
  def about 
  end

  def help
  end
  
  def destroy
  end

  def restaurants
    @restaurant = Restaurant.new
  end

  def items
    @item = Item.new
  end
  def check_restaurant
    if user_signed_in?
      if current_user.clearance < 1 
        flash[:alert] = "This is not a restaurant account"
        redirect_to root_path
      end
    else 
      flash[:alert] = "Sign in"
      redirect_to new_user_session_path
    end
  end

  def check_has_restaurant 
    current_user.restaurants.length > 0
  end
end

class StaticPagesController < ApplicationController

  def home
    @order = Order.new
    if user_signed_in? 
      last_order = current_user.orders.last
      @items = last_order ? last_order.items : nil
      if last_order.nil?
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
        @order = last_order
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
 
end

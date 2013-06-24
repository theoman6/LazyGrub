class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = Order.where('expiration > ?', Time.now.utc - 4.hours)
  end

  def new
  end
  
  def create
    tmp = params['order']['item_ids']
    params['order']['item_ids'] = [] 
    tmp.each_pair do |key, value| 
      params['order']['item_ids'].concat([key] * value.to_i)
    end
    @order = current_user.orders.build(params['order'])
    if @order.save
      flash[:success] = 'Order placed'
      redirect_to orders_path
    else 
      render 'static_pages/home'
    end
  end

  def destroy
  end
end

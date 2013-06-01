class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def new
  end
  
  def create
    @order = current_user.orders.build(params[:order])
    if @order.save
      flash[:success] = 'Order placed'
      redirect_to root_path
    else 
      render 'static_pages/home'
    end
  end

  def destroy
  end
end

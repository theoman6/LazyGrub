class OrdersController < ApplicationController
  def index
    @orders = Order.where('updated_at > ?', 1.month.ago)
    @current_count = @orders.count{|order| order.updated_at + 1.hour > Time.now}
    @preset = params[:preset] || 'index'
    @order_index = true
  end

  def new
  end
  
  def create
    if user_signed_in?
      tmp = params['order']['item_ids']
      choices = [] 
      tmp.each_pair do |key, value| 
        value.to_i.times do 
          choices << {:item_id => key, :description => params['order']['item_descriptions'][key].shift[1]}
        end
      end
      params['order'].delete('item_descriptions')
      params['order'].delete('item_ids')
      @order = current_user.orders.build(params['order'])
      choices.map!{|choice| Choice.new(choice)}
      if @order.save
        choices.map! do |choice| 
          choice[:order_id] = @order.id
          choice.save
          choice
        end
        flash[:success] = 'Order placed'
        redirect_to orders_path({:preset => 'placed'})
      else 
        flash[:alert] = "Order failed, try again"
        @items = choices
        render 'static_pages/home'
      end
    else
      flash[:alert] = "You must be signed in to place orders"
      redirect_to new_user_session_path
    end
  end

  def update
    descs = params['order'].delete('item_descriptions')
    ids = params['order'].delete('item_ids')
    order = Order.find(params[:id])
    if !Order.claimer
      order.update_attributes(params['order'])
      order.choices.each{|choice| choice.destroy}
      choices = [] 
      ids.each_pair do |key, value| 
        value.to_i.times do 
          choices << {:item_id => key, :description => descs[key].shift[1]}
        end
      end
      choices.each do |row| 
          row[:order_id] = order.id
          choice = Choice.new(row)
          choice.save
      end
      redirect_to orders_path
    else 
      flash[:alert] = "Someone has already claimed this order. It can no longer be edited."
      redirect_to orders_path
    end
  end


  def destroy
    order = Order.find(params[:id])
    if !order.claimer
      order.destroy
      flash[:success] = 'Order Cancelled'
    else
      flash[:alert] = 'Someone has already claimed this order. It can no longer be deleted.'
    end
    redirect_to root_path
  end

  def claim
    order = Order.find(params[:id])
    if !order.claimer && order.available?
      order.claimer = current_user 
      order.save
      flash[:success] = "You have successfully claimed that order. You have one hour to deliver it."
      redirect_to orders_path({:preset => 'claimed'})
    else 
      flash[:alet] = "That order is no longer available"
      redirect_to orders_path
    end
  end

  def unclaim
    order = Order.find(params[:id])
    if order.available?
      order.claimer = nil 
      order.save
      flash[:success] = "You have unclaimed that order."
      redirect_to orders_path
    else
      flash[:alet] = "You should have delivered that order already. It can no longer be unclaimed."
    end
  end

  def edit
    @order = Order.find(params[:id])
    @items = @order.choices
  end
end

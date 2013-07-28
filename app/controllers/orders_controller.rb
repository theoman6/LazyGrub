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
    if @order.save
      choices.each do |row| 
        row[:order_id] = @order.id
        choice = Choice.new(row)
        choice.save
      end
      flash[:success] = 'Order placed'
      redirect_to orders_path
    else 
      flash[:alert] = "Order failed: see form for details"
      render 'static_pages/home'
    end
  end

  def destroy
  end

  def claim
    order = Order.find(params[:id])
    order.claimer = current_user unless order.claimer
    order.save
    @preset = 'claimed'
    redirect_to orders_path({:preset => 'claimed'})
  end
end

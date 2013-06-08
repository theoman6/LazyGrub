class ItemsController < ApplicationController
  def index
    @items = Item.where(:restaurant_id => params[:restaurant_id])
  end

	def new
    @item = Restaurant.find(params[:restaurant_id]).items.new
	end

  def edit 
    @item = Item.find(params[:id])
  end

	def create
    @item = Restaurant.find(params[:restaurant_id]).items.build(params[:item])
    if @item.save
      flash[:success] = 'Created ' + @item.name + ' for ' + @item.restaurant.name
      redirect_to restaurant_items_path(params[:restaurant_id])
    else 
      flash[:alert] = "Item failed"
      redirect_to restaurant_items_path(params[:restaurant_id])
    end
	end

	def destroy
	end

  def update
    if Item.find(params[:id]).update_attributes(params[:item])
      flash[:success] = "Successfully updated"
    else 
      falsh[:alert] = "Failed to update"
    end
      redirect_to restaurant_items_path(params[:restaurant_id])
  end      

end

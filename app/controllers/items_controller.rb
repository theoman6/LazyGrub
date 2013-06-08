class ItemsController < ApplicationController
	def new
	end

	def create
    binding.pry
    @item = Item.create(params[:item])
    if @item.save
      flash[:success] = 'Created ' + @item.name + ' for ' + Restaurant.find(@item.restaurant_id).name
      redirect_to items_create_path
    else 
      flash[:alert] = "Item failed"
      redirect_to items_create_path
    end
	end

	def destroy
	end

end


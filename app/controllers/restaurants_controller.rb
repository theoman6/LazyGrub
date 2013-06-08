class RestaurantsController < ApplicationController

	def new
	end

	def create
    @restaurant = current_user.restaurants.build(params[:restaurant])
    @restaurant[:approved] = current_user.clearance < 2 ? false : true
    if @restaurant.save
      flash[:success] = 'Created Restaurant'
      redirect_to items_create_path
    else 
      redirect_to root_path
    end
	end

	def destroy
	end

end


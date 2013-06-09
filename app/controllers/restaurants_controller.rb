class RestaurantsController < ApplicationController

	def new
    @restaurant = current_user.restaurants.new
	end

  def index
    @restaurants = current_user.clearance > 2 ? Restaurant.all : current_user.restaurants.all 
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

	def create
    @restaurant = current_user.restaurants.build(params[:restaurant])
    @restaurant[:approved] = current_user.clearance < 2 ? false : true
    if @restaurant.save
      flash[:success] = 'Created Restaurant, you can add menu items while waiting for approval'
      redirect_to restaurants_path
    else 
      falsh[:alert] = "Failed to create restaurant"
      redirect_to root_path
    end
	end

	def destroy
	end

  def update
    if Restaurant.find(params[:id]).update_attributes(params[:restaurant])
      flash[:success] = "Successfully updated"
    else 
      falsh[:alert] = "Failed to update"
    end
    redirect_to restaurants_path
  end

end


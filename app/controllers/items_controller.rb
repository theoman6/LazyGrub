class ItemsController < ApplicationController
  def index
    @items = Item.where(:restaurant_id => params[:restaurant_id])
  end

	def new
    rest = Restaurant.find(params[:restaurant_id])
    @item = rest.items.new
    @categories = rest.categories.pluck(:name)
	end

  def edit 
    @item = Item.find(params[:id])
    @item[:category_id] = @item[:category_id] ? Category.find(@item[:category_id])[:name] : ''
    @categories = @item.restaurant.categories.pluck(:name)
  end

	def create
    rest = Restaurant.find(params[:restaurant_id])
    @item = rest.items.build(params[:item])
    params[:item][:category_id] = 'Miscellaneous' if params[:item][:category_id] == ''
    category = rest.categories.where(:name => params[:item][:category_id])
    if category.blank?
      category = [rest.categories.create(:name => params[:item][:category_id])]
    end
    @item[:category_id] = category[0][:id]

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
    rest = Restaurant.find(params[:restaurant_id])
    params[:item][:category_id] = 'Miscellaneous' if params[:item][:category_id] == ''
    category = rest.categories.where(:name => params[:item][:category_id])
    if category.blank?
      category = [rest.categories.create(:name => params[:item][:category_id])]
    end
    params[:item][:category_id] = category[0][:id]

    if Item.find(params[:id]).update_attributes(params[:item])
      flash[:success] = "Successfully updated"
    else 
      falsh[:alert] = "Failed to update"
    end
      redirect_to restaurant_items_path(params[:restaurant_id])
  end      

  def list
    @rest = Restaurant.find(params[:restaurant_id])
    @order = Order.new
    render :layout => false
  end


end

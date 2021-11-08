class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_response_not_found
  def index
    if(params[:user_id])
      user= User.find(params[:user_id])
      items= user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item=Item.find(params[:id])
    render json: item
  end

  def create
    item= Item.create!(items_params)
    render json:item, status: :created
  end

  private

  def items_params 
      params.permit(:name,:description,:price,:user_id)
  end

  def render_response_not_found
    render json: {errors: "user not found"}, status: :not_found
  end
end

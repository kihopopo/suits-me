class Public::FavoritesController < ApplicationController
  before_action :post_image_params

  def create
    Favorite.create(customer_id: current_customer.id, post_image_id: params[:id])
    # # post_image = PostImage.find(params[:post_image_id])
    # favorite = current_customer.favorites.new(post_image_id: post_image.id)
    # favorite.save
    # redirect_to post_image_path(post_image)
  end

  def destroy
    Favorite.create(customer_id: current_customer.id, post_image_id: params[:id]).destroy
    # post_image = PostImage.find(params[:post_image_id])
    # favorite = current_customer.favorites.find_by(post_image_id: post_image.id)
    # favorite.destroy
    # redirect_to post_image_path(post_image)
  end


  private

  def post_image_params
    @post_image = PostImage.find(params[:id])
  end
end


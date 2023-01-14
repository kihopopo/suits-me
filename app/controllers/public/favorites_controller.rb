class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    # Favorite.create(customer_id: current_customer.id, post_image_id: params[:id])
    @post_image = PostImage.find(params[:post_image_id])
    favorite = @post_image.favorites.new(customer_id: current_customer.id)
    favorite.save
    # redirect_to post_image_path(post_image)
  end

  def destroy
    # Favorite.find_by(customer_id: current_customer.id, post_image_id: params[:id]).destroy
    @post_image = PostImage.find(params[:post_image_id])
    favorite = @post_image.favorites.find_by(customer_id: current_customer.id)
    favorite.destroy
    # redirect_to post_image_path(post_image)
  end

end
class Public::PostImagesController < ApplicationController
  before_action :authenticate_customer!
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.customer_id = current_customer.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end

  def index
    @post_images = PostImage.page(params[:page]).per(8)
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to '/post_images'
  end

   private

  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption, :name, :price)
  end

end
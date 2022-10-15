class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    tag_ids = params[:tag_ids] || [] # [2,4]
    if tag_ids.size > 0
      item_ids = ItemTag.where(tag_id: tag_ids).pluck('item_id') # [1, 1]
      @items = Item.where(id: item_ids.uniq).page(params[:page]).per(8)
    else
      @items = Item.page(params[:page]).per(8)
    end
    @tags = Tag.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @comments = @item.comments
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
    if @comment.customer == current_customer
      render "edit"
    else
      redirect_to items_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :genre_id, :price, :is_active, :image)
  end
end
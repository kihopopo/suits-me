class Public::ItemsController < ApplicationController
  def index
    tag_ids = params[:tag_ids] || [] # [2,4]
    if tag_ids.size > 0
      item_ids = ItemTag.where(tag_id: tag_ids).pluck('item_id') # [1, 1]
      @items = Item.where(id: item_ids.uniq)
    else
      @items = Item.all
    end
    @tags = Tag.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @comments = @item.comments
    @comment = Comment.new
  end

  # def destroy
  #   comment = Comment.find(params[:id])
  #   comment.destroy
  #   redirect_to item_path(@item)
  # end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :genre_id, :price, :is_active, :image)
  end
end
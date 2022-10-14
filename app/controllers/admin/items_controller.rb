class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      params[:item][:tag_ids].shift

      params[:item][:tag_ids].each do |tag|

        @item.item_tags.create!(tag_id: tag)
      end

    redirect_to admin_item_path(@item)
    else
    render :new
    end
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @comments = @item.comments
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :genre_id, :price, :is_active, :image, :comment , tag_ids: [])
  end

end

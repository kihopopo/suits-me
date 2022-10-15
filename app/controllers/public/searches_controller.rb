class Public::SearchesController < ApplicationController
  def search
    unless params[:word].blank?
      @items = Item.search(params[:word], params[:method]).page(params[:page]).per(8)
    else
      @items = Item.page(params[:page]).per(8)
    end
  end
end

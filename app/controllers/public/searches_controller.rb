class Public::SearchesController < ApplicationController
  def search
    unless params[:word].blank?
      @items = Item.search(params[:word], params[:method])
    else
      @items = Item.all
    end
  end
end

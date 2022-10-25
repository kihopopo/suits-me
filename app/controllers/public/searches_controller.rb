class Public::SearchesController < ApplicationController
  def search
    if params[:type] == "item"
      unless params[:word].blank?
        @items = Item.search(params[:word], params[:method]).page(params[:page]).per(8)
      else
        @items = Item.page(params[:page]).per(8)
      end
    else
      unless params[:word].blank?
        @items = Kaminari.paginate_array(Tag.search(params[:word], params[:method]).map { |t| t.items }.flatten.uniq).page(params[:page]).per(8)
      else
        @items = Item.page(params[:page]).per(8)
      end
    end
  end
end

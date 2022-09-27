class Public::ColorsController < ApplicationController
  def new
  end

  def create
    @color = Color.new(color_params)
    params[:color][:question] ? @color.question = params[:color][:question].join("") : false
    if @color.save
        flash[:success] = "診断が完了しました"
        redirect_to color_path(@color.id)
    else
        redirect_to :action => "new"
    end
  end

  def index
    @color = Color.new
  end

  def show
    @color = Color.find_by(id: params[:id])
  end

  private
  def color_params
      params.require(:color).permit(:id, question: [])
  end
end

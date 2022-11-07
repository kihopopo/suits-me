class Public::ColorsController < ApplicationController
  before_action :authenticate_customer!
  def new
  end

  def create
    @color = Color.new(color_params)
    if params[:color][:question]
      params[:color][:question] ? @color.question = params[:color][:question].join("") : false
      #TODO: 論理演算子に関する補足: https://pikawaka.com/ruby/logical-operators
      #Array#include?を用いた
      valid = false
      if @color.question.include?("1") && @color.question.include?("2")
      elsif @color.question.include?("3") && @color.question.include?("4")
      elsif @color.question.include?("5") && @color.question.include?("6")
      elsif @color.question.include?("7") && @color.question.include?("8")
      else
        valid = true
      end
      if valid && @color.question.size == 4 && @color.save
          flash[:success] = "診断が完了しました"
          redirect_to color_path(@color.id)
      else
          flash[:danger] = "診断ができませんでした。もう一度診断し直してください。"
          render :index
      end
    else
        flash[:danger] = "入力がないので診断ができませんでした。もう一度診断し直してください。"
        render :index
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

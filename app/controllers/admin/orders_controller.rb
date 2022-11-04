class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    if @order.status == "paid_up"
       @order.order_details.each do |order_detail|
        order_detail.update(making_status:"waiting_start")
       end
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
  params.require(:order).permit(:postal_code, :address, :name,:status)
  end

end

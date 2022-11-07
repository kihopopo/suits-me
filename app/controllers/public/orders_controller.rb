class Public::OrdersController < ApplicationController
  before_action :correct_customer, only: [:show]
  def new
    if current_customer.cart_items.size == 0
      redirect_to cart_items_path
    else
      @order = Order.new
      @customer = current_customer
      @payments = Order.payment_methods
    end
  end


  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item_id
      order_detail.price = cart_item.item.price
      order_detail.amount = cart_item.amount
      order_detail.save
    end
    cart_items.destroy_all
    redirect_to orders_complete_path
  end


  def index
    @orders = current_customer.orders.page(params[:page]).per(15)
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    validate_new_user(params)
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method]
   if params[:order][:select_address] == "1"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.full_name
   elsif params[:order][:select_address] == "2"
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
   end
  end

  def confirm_error
    flash[:danger]="不正な操作が行われました。もう一度やり直してください。"
    redirect_to new_order_path
  end

  private

  def validate_new_user(params)
    if params[:order][:select_address] == "3" && (params[:order][:address] == "" ||  params[:order][:postal_code] == "" ||   params[:order][:name] == "" )
      redirect_to new_order_path, alert: "入力をしていない項目があります。もう一度入力してください。"
    end
  end

  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
  end

  def correct_customer
    @order = Order.find(params[:id])
    @customer = @order.customer
    redirect_to(admin_path) unless @customer == current_customer
  end

end

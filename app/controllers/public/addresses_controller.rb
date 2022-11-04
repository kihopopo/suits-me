class Public::AddressesController < ApplicationController
  before_action :correct_customer, only: [:edit, :update, :destroy]
  def index
   @address = Address.new
   @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path(@address.id)
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to '/addresses'
  end

   private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

  def correct_customer
    @address = Address.find(params[:id])
    @customer = @address.customer
    redirect_to(addresses_path) unless @customer == current_customer
  end
end

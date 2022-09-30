class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
    flash[:success]='会員情報の更新が完了しました。'
    redirect_to customers_my_page_path
    else
      render :edit
    end
  end

  def unsubscibe
    @customer = Customer.find(params[:id])
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:info]="ありがとうございました。またのご利用を心からお待ちしております"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :email, :username, :is_deleted)
  end
end


class ApplicationController < ActionController::Base
  # before_action :authenticate_admin!, only: [:top, :about, :items]
  # before_action :authenticate_customer!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :username, :postal_code, :address, :telephone_number])
  end
end

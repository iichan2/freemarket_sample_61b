class ApplicationController < ActionController::Base

  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!, except: :items
  protect_from_forgery with: :exception

  
  private

  def production?
    Rails.env.production?
  end


  def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
  end 

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :nickname, 
        :password, 
        :password_confirmation,
        :first_name, 
        :last_name, 
        :kana_first_name, 
        :kana_last_name, 
        :birth_year, 
        :birth_month,
        :birth_day,  
        :tel_number, 
        :postal_code, 
        :ken, 
        :map, 
        :banchi, 
        :building, 
        :tel_number
        ])
  end

end


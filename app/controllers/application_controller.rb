class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  UN = ENV['BASIC_AUTH_USER']
  PS = ENV['BASIC_AUTH_PASSWORD']
  ENV['BASIC_AUTH_USER'] = UN
  ENV['BASIC_AUTH_PASSWORD'] = PS
  
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
        :password, 
        :email
        ])
  end

end


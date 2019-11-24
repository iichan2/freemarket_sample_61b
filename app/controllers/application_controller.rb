class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  UN = ENV['BASIC_AUTH_USER']
  PS = ENV['BASIC_AUTH_PASSWORD']
  ENV['BASIC_AUTH_USER'] = UN
  ENV['BASIC_AUTH_PASSWORD'] = PS
  
  def error_page
  end

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
      devise_parameter_sanitizer.permit(:sign_up, keys: [:password, :email])
    end

    def session_clear
      session[:payjpUser_id] = nil
      session[:nickname] = nil
      session[:email] = nil
      session[:password] = nil
      session[:last_name] = nil
      session[:first_name] = nil
      session[:kana_last_name] = nil
      session[:kana_first_name] = nil
      session[:birth_year] = nil
      session[:birth_month] = nil
      session[:birth_day] = nil
      session[:tel_number] = nil
      session['devise.omniauth_data'] = nil
      session[:payjpToken] = nil
      session[:f_name] = nil
      session[:l_name] = nil
      session[:kana_f_name] = nil
      session[:kana_l_name] = nil
      session[:postal_code] = nil
      session[:ken] = nil
      session[:map] = nil
      session[:banchi] = nil
      session[:building] = nil
      session[:tel_number2] = nil
      session[:item_id] = nil
      session[:sns_id] = nil
    end
end
class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  # before_action :authenticate_user! 

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
      end
  end 

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :password, :first_name, :last_name, :kana_first_name, :kana_last_name, :birthday, :tel_number, :postal_code, :ken, :map, :banchi, :building, :tel_number])
  end
end


# def configure_permitted_parameters
#   added_attrs = [ :email, :nickname, :password, :password_confirmation]
#   devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
#   devise_parameter_sanitizer.permit :account_update, keys: added_attrs
#   devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
# end


# config.generators do |g|
#   # 色々な記述があるので、一番下に追記する
#   g.test_framework :rspec,
#                   fixtures: true,
#                   view_specs: false,
#                   helper_specs: false,
#                   routing_specs: false,
#                   controller_specs: true,
#                   request_specs: false
#   g.fixture_replacement :factory_bot, dir: "spec/factories"
# end
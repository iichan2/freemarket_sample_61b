class CardsController < ApplicationController 
  before_action :redirct_error_check, only: [:error_page]
  before_action :session_clear, only: [:error_page]
  require "payjp" 

  def new 
  end 

  def pay 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] 
    if payjp_params['payjpToken'].blank? 
      redirect_to error_page_cards_path
    else 
      customer = Payjp::Customer.create( 
      description: '登録テスト', 
      email: current_user.email, 
      card: payjp_params['payjpToken'], 
      metadata: {user_id: current_user.id} 
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card) 
      if @card.save 
        if session[:item_id].present? 
          redirect_to transaction_item_path(session[:item_id]) 
          session[:item_id] = nil 
        else 
          redirect_to payment_user_path(current_user.id)
        end 
      else 
        redirect_to error_page_cards_path
      end 
    end 
  end 
  
  def destroy 
    card = current_user.cards.first 
    unless card.blank?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] 
      customer = Payjp::Customer.retrieve(card.customer_id) 
      customer.delete 
      card.delete 
    end 
      redirect_to payment_user_path(current_user.id)
  end
  
  def error_page
  end

  private

  def payjp_params
    params.permit(:payjpToken)
  end
end
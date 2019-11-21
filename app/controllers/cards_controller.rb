class CardsController < ApplicationController 
  before_action :authenticate_user! 
  require "payjp" 

  def new 
  end 

  def pay 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] 
    if params['payjpToken'].blank? 
      redirect_to action: "new" 
    else 
      customer = Payjp::Customer.create( 
      description: '登録テスト', 
      email: current_user.email, 
      card: params['payjpToken'], 
      metadata: {user_id: current_user.id} 
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card) 
      if @card.save 
        if session[:item_id].present? 
          redirect_to controller:"items", action: "transaction",id: session[:item_id] 
          session[:item_id] = nil 
        else 
          redirect_to controller:"users", action: "payment",id: current_user.id 
        end 
      else 
        redirect_to action: "pay" 
      end 
    end 
  end 
  
  def delete 
    card = current_user.cards.first 
    unless card.blank?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"] 
      customer = Payjp::Customer.retrieve(card.customer_id) 
      customer.delete 
      card.delete 
    end 
      redirect_to controller:"users", action: "payment",id: current_user.id 
  end 
end 
class UsersController < ApplicationController
  before_action :check_user, except:[:new]
  before_action :authenticate_user!
  before_action :set_delivery_params, only:[:identification]
  before_action :set_params, 
    only:[:show, :edit, :update, :payment, :identification, :logout, 
          :status_sell, :status_sell_trading, :status_sold, :status_buy_trading, :status_bought]

  def show
  end

  def edit
  end

  def update  
    if @user.update(user_params)
      render :edit
    else
      render :edit
    end
  end

  def payment
    @card = Card.find_by(user_id: current_user.id)
    unless @card.blank?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def identification
  end

  def logout
  end

  def status_sell
    @items = current_user.items.includes(:images).state('出品中')+ current_user.items.includes(:images).state('停止中')
  end

  def status_sell_trading
    @items = current_user.items.includes(:images).state('取引中')
  end

  def status_sold
    @items = current_user.items.includes(:images).state('売却済')
  end
  
  def status_buy_trading
    @items = Item.where(buyer_id: @user.id).includes(:images).state('取引中')
  end

  def status_bought
    @items = Item.where(buyer_id: @user.id).includes(:images).state('売却済')
  end
  
  private
    def check_user
      user = User.find(params[:id])
      if user.id != current_user.id
        redirect_to(root_path)
      end
    end

    def set_params
      @user = User.find(params[:id])
    end

    def set_delivery_params
      user = User.find(params[:id])
      @delivery = Delivery.find(user.delivery_id)
    end

    def user_params
      params.require(:user).permit(:nickname, :profile)
    end
end
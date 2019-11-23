class UsersController < ApplicationController
  before_action :check_user, except:[:new]
  before_action :authenticate_user!, except:[:logout]
  before_action :set_params, 
    only:[:identification,:show, :edit, :update, :payment, :logout, 
          :trading, :sending, :status_sell,:status_trading,:status_sold,
          :status_delivery,:status_bought,:prof_update]
  
  def payment
    @card = Card.where(user_id: current_user.id).first
    unless @card.blank?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def show
  end

  def identification
    @delivery = Delivery.find(params[:id])
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

  def status_sell
    @items = current_user.items.includes(:images).state('出品中')+ current_user.items.includes(:images).state('停止中')
  end

  def status_trading
    @items = current_user.items.includes(:images).state('取引中')
  end

  def status_sold
    @items = current_user.items.includes(:images).state('売却済')
  end
  
  def status_delivery
    @items = Item.where(buyer_id: @user.id).includes(:images).state('取引中')
  end

  def status_bought
    @items = Item.where(buyer_id: @user.id).includes(:images).state('売却済')
  end

  def logout
  end

  def sign_out
    if user_signed_in?
      @user = current_user.id
      @user = nil
      redirect_to root_path
    end
  end
  
  private
    def set_params
      @user = User.find(params[:id])
    end

    def check_user
      user = User.find(params[:id])
      if user.id != current_user.id
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(:nickname, :profile)
    end
end
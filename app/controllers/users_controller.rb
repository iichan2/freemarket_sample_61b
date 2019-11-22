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
    exhibition_state = "出品中"
    who_sold = "user"
    @items_images = create_one_item_one_image(exhibition_state,who_sold)
  end

  def status_trading
    exhibition_state = "取引中"
    who_sold = "user"
    @items_images = create_one_item_one_image(exhibition_state,who_sold)
  end

  def status_sold
    exhibition_state = "売却済"
    who_sold = "user"
    @items_images = create_one_item_one_image(exhibition_state,who_sold)
  end
  
  def status_delivery
    exhibition_state = "取引中"
    who_sold = "buyer"
    @items_images = create_one_item_one_image(exhibition_state,who_sold)
  end

  def status_bought
    exhibition_state = "売却済"
    who_sold = "buyer"
    @items_images = create_one_item_one_image(exhibition_state,who_sold)
  end

  def create_one_item_one_image(exhibition_state,who)
    if who == "user"
      items = Item.where(user_id: current_user.id)
    else
      items = Item.where(buyer_id: current_user.id)
    end
    able_items = items.where(exhibition_state: exhibition_state)
    items_images = []
    able_items.each do |item|
      arry = Image.where(item_id: item.id)
      image = arry.first
      hash = {item: item,image: image}
      items_images << hash
    end
    return items_images
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
class UsersController < ApplicationController
  before_action :check_user, except:[:new]
  before_action :authenticate_user!, except:[:logout]
  before_action :set_params, only: 
    [:identification,:show, :edit, :update, :payment, :logout, 
      :trading, :sending, :status_sell,:status_trading,:status_sold,
      :status_delivery,:status_bought,:prof_update]
  
  before_action :set_item_image_params, only: [:sending, :trading]
  
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
    @ken = Prefecture.find(@delivery.ken)
  end

  def edit
    @user = User.find(current_user.id)  
  end

  def prof_update
    @user.update(
      nickname: params[:nickname],
      profile: params[:profile]
    )
    if @user.update(
      nickname: params[:nickname],
      profile: params[:profile]
    )
      redirect_to user_path
    else
      render :edit
    end 
  end

  def trading
  end

  def sending
  end

  def status_sell
    items = Item.where(user_id: @user.id)
    able_items = items.where("(exhibition_state = ?) OR (exhibition_state = ?)", "出品中", "停止中")
    @items_images = []
    able_items.each do |item|
      arry = Image.where(item_id: item.id)
      image = arry.first
      hash = {item: item,image: image}
      @items_images << hash
    end
  end

  def status_trading
    items = Item.where(user_id: @user.id)
    able_items = items.where(exhibition_state: "取引中")
    @items_images = []
    able_items.each do |item|
      arry = Image.where(item_id: item.id)
      image = arry.first
      hash = {item: item,image: image}
      @items_images << hash
  end
end

  def status_sold
    items = Item.where(user_id: @user.id)
    able_items = items.where(exhibition_state: "売却済")
    @items_images = []
    able_items.each do |item|
      arry = Image.where(item_id: item.id)
      image = arry.first
      hash = {item: item,image: image}
      @items_images << hash
    end
  end
  
  def status_delivery
    items = Item.where(buyer_id: @user.id)
    able_items = items.where(exhibition_state: "取引中")
    @items_images = []
    able_items.each do |item|
      arry = Image.where(item_id: item.id)
      image = arry.first
      hash = {item: item,image: image}
      @items_images << hash
    end
  end

  def status_bought
    items = Item.where(buyer_id: @user.id)
    able_items = items.where(exhibition_state: "売却済")
    @items_images = []
    able_items.each do |item|
      arry = Image.where(item_id: item.id)
      image = arry.first
      hash = {item: item,image: image}
      @items_images << hash
    end
  end

  def update  
    if @user.update(user_params)
      flash[:notice] = "変更しました"
      render :edit
    else
      flash[:notice] = "入力してください"
      render :edit
    end
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

  def yu
  end
  
  private
    def set_params
      @user = User.find(params[:id])
    end

    def set_item_image_params
    end

    def check_user
        user = User.find(params[:id])
        if user.id != current_user.id
          redirect_to root_path
        end
    end

    def user_params
      params.require(:user).permit(:nickname, :profile )
    end

end
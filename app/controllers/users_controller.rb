class UsersController < ApplicationController
  before_action :check_user, except:[:new]
  before_action :authenticate_user!, except:[:logout]
  before_action :set_params, only: 
    [:identification,:show, :edit, :update, :payment, :logout, 
      :trading, :sending, :status_sell,:status_trading,:status_sold,
      :status_delivery,:status_bought,:prof_update]
  
  before_action :set_item_image_params, only: [:sending, :trading]
  
  def payment
  end

  def show
    
  end

  def identification
    ken_to_name = ["海外","北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県","茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県","新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県","静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    @delivery = Delivery.find(params[:id])
    @ken = ken_to_name[@delivery[:ken]]
  end

  def edit
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
    if @user.save
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
      # @item = Item.find(params[:id])
      # @image = Image.find(params[:id])
    end

    def check_user
        user = User.find(params[:id])
        if user.id != current_user.id
          redirect_to root_path
        end
    end
end
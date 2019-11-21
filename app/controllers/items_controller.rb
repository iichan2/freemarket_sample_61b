class ItemsController < ApplicationController 
  before_action :authenticate_user!, except:[:index, :get_category_children, :get_category_grandchildren, :transaction, :show, :show_deleted] 
  before_action :create_item, only:[:create]
  before_action :session_clear,only:[:index]

  def index
    items = Item.where(exhibition_state: "出品中")
    @ladies_items = items.lady(1).take(10)
    @mens_items = items.lady(2).take(10)
    @appliance_items = items.lady(8).take(10)
    @toys_items = items.lady(6).take(10)
    @kubota_items = items.where(brand_id: 1).limit(10)
    @inoue_items = items.where(brand_id: 3).limit(10)
    @shioya_items = items.where(brand_id: 2).limit(10)
    @tonochi_items = items.where(brand_id: 5).limit(10)
  end

  def new
    @item = Item.new
    @image = Image.new
    @category_parents = Category.where(ancestry: nil).map{|i| [i.category, i.id]}
  end

  def edit
    @item = Item.find(params[:id])
    item_user = User.find(@item.user_id)
    if item_user.id == current_user.id
      @category_parents = Category.where(ancestry: nil).map{|i| [i.category, i.id]}
      @category_grandchild = Category.find(@item.category_id)
      @category_child = @category_grandchild.parent
      @category_parent = @category_child.parent
      @parents = Category.where(ancestry: nil)
      @image = @item.images 
      @category_gc_now = Category.find(@item.category_id)
      @category_c_now = @category_gc_now.parent
      @category_p_now = @category_c_now.parent
      @p_c_children = @category_p_now.children
      @c_gc_children = @category_c_now.children
    else
      redirect_to root_path
    end
  end

  def get_category_children 
    @category_children = Category.find(params[:parent_id]).children 
  end 

  def get_category_grandchildren 
    @category_grandchildren = Category.find(params[:child_id]).children 
  end 
  
  def update
    @item = Item.find(params[:id])
    item_user = User.find(@item.user_id)
    if item_user.id == current_user.id
      if params[:item][:images_attributes][:"0"][:image_url].nil?
        if @item.update!(update_item_params)
          redirect_to status_sell_user_path(current_user.id)
        else
          redirect_to controller: "items", action: "edit", id:"#{@item.id}"
        end
      else
        if @item.update!(update_item_params_without_image)
          uploaded_files = [
            params[:item][:images_attributes][:"0"],
            params[:item][:images_attributes][:"1"],
            params[:item][:images_attributes][:"2"],
            params[:item][:images_attributes][:"3"],
            params[:item][:images_attributes][:"5"],
            params[:item][:images_attributes][:"4"],
            params[:item][:images_attributes][:"6"],
            params[:item][:images_attributes][:"7"],
            params[:item][:images_attributes][:"8"],
            params[:item][:images_attributes][:"9"]
          ]
          num = 1
          uploaded_files.each do |uf|
            if uf.nil?
              num += 1
            else
              date = DateTime.now.strftime('%Y%m%d%H%M%S').to_i
              if uf[:image_url].kind_of?(Array)
                uff = uf[:image_url][0]
              else
                uff = uf[:image_url]
              end
              if uff.nil?
                num += 1
              else
                output_path = Rails.root.join('public', "#{@item.id}", "#{date + num}")
                File.open(output_path, 'w+b') do |fp|
                  fp.write  uff.read
                end
                save_path = "/#{@item.id}/#{date + num}"
                @image = Image.create(item_id:@item.id,image_url:save_path)
                num += 1
              end 
            end
          end
          redirect_to status_sell_user_path(current_user.id)
        else
          redirect_to controller: "items", action: "edit", id:"#{@item.id}"
        end
        # @category_parents = Category.where(ancestry: nil).map{|i| [i.category, i.id]}
        # @category_grandchild = Category.find(@item.category_id)
        # @category_child = @category_grandchild.parent
        # @category_parent = @category_child.parent
        # redirect_to edit_item_path(@item)
      end
    else
      redirect_to root_path
    end
  end
  
  def create_item
    @item = Item.create!(item_params)
    @item.update(exhibition_state: "出品中")
    session[:item_id] = @item.id
  end

  def transaction
    if user_signed_in?
      @user = User.find(current_user.id)
      @prefecture_name = Prefecture.find(@user.delivery.ken).name
      @del = "#{@kprefecture_name} #{@user.delivery.map} #{@user.delivery.banchi} #{@user.delivery.building}"
      @item = Item.find(params[:id])
      @image = @item.images.first
      if @item.exhibition_state == "出品中"
        session[:item_id] = @item.id
        card = Card.where(user_id: current_user.id).first
        #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
        if card.blank?
          #登録された情報がない場合にカード登録画面に移動
          redirect_to controller: "cards", action: "new"
        else
          Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
          #保管した顧客IDでpayjpから情報取得
          customer = Payjp::Customer.retrieve(card.customer_id)
          #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
          @default_card_information = customer.cards.retrieve(card.card_id)
        end
      else
        redirect_to root_path
      end
    else
      redirect_to '/users/sign_in' 
    end 
  end

  def pay
    require 'payjp'
    @item = Item.find(session[:item_id])
    @user = current_user
    card = Card.where(user_id: @user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    charge = Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_id,
      card: card.card_id,
      currency: 'jpy'
    )
    session[:item_id] = nil
    @item.update(buyer_id: @user.id, exhibition_state: "取引中")
    redirect_to action:"bought", controller: "items", id: @item.id
  end

  def show
    @item = Item.find(params[:id])
    @saler = User.find(@item.user_id)
    session[:item_id] = @item.id
    if @item.exhibition_state == "削除済"
      redirect_to controller: 'items', action: 'show_deleted'
    end
    @images = @item.images
    @comment = Comment.new
    @commented = Comment.where(item_id: @item.id)
    items = Item.where(user_id: @item.user_id)
    @items = items.where("(exhibition_state = ?) OR (exhibition_state = ?)", "出品中", "停止中")
    @item_seller_user = User.find(@item.user_id)
  end
  
  def comment_create
    if @comment = Comment.create(comment_params)
      redirect_to controller: 'items', action: 'show', id: comment_params[:item_id]
    end
  end

  def saler
    @item = Item.find(params[:id])
    able_items = Item.where(user_id: @item.user.id)
    @items_images = []
    able_items.each do |item|
      arry = Image.where(item_id: item.id)
      image = arry.first
      hash = {item: item , image: image}
      @items_images << hash
    end
  end

  def show_deleted #アイテムなかった時に飛ぶところ
  end

  def item_stop
    @item = Item.find(session[:item_id])
    session[:item_id] = nil
    @item.update(exhibition_state: "停止中")
    redirect_to controller: 'items', action: 'show', id: @item.id
  end

  def item_destroy
    @item = Item.find(session[:item_id])
    session[:item_id] = nil
    if @item.update(exhibition_state: "削除済")
      user = User.find(@item.user_id)
      redirect_to controller: 'users', action: 'show', id: user.id
    else
      redirect_to error_page_items_path
    end
  end

  def error_page
  end

  def bought
    @item = Item.find(params[:id])
    @buyer = User.find(@item.buyer_id)
    card = Card.where(user_id: current_user.id).first
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = customer.cards.retrieve(card.card_id)
    @delivery = Delivery.find(current_user.id)
    @kenname = Prefecture.find(@buyer.delivery.ken).name
    @del = "#{@kenname} #{@buyer.delivery.map} #{@buyer.delivery.banchi} #{@buyer.delivery.building}"
    @image = @item.images.first
  end

  def create
    item_id = session[:item_id]
    session[:item_id] = nil
    if params[:item][:image].nil?
    else
      uploaded_file = params[:item][:image][:image_url]
      FileUtils.mkdir_p("./public/#{item_id}") unless FileTest.exist?("./public/#{item_id}")
      output_path = Rails.root.join('public', "#{item_id}", "0")
      File.open(output_path, 'w+b') do |fp|
        fp.write  uploaded_file.read
      end
      save_path = "/#{item_id}/0"
      @image = Image.create(item_id:item_id,image_url:save_path)
    end

    checknil = params[:item][:images_attributes]
    if checknil.nil?
    else
      uploaded_files = [
        params[:item][:images_attributes][:"1"],
        params[:item][:images_attributes][:"2"],
        params[:item][:images_attributes][:"3"],
        params[:item][:images_attributes][:"5"],
        params[:item][:images_attributes][:"4"],
        params[:item][:images_attributes][:"6"],
        params[:item][:images_attributes][:"7"],
        params[:item][:images_attributes][:"8"],
        params[:item][:images_attributes][:"9"]
      ]
      num = 1
      uploaded_files.each do |uf|
        if uf.nil?
          num += 1
        else
          uff = uf[:image_url][0]
          o_p = Rails.root.join('public', "#{item_id}", "#{num}")
          File.open(o_p, 'w+b') do |fp|
            fp.write  uff.read
          end
          save_path = "/#{item_id}/#{num}"
          @image = Image.create(item_id:item_id,image_url:save_path)
          num += 1
        end
      end
    end
    redirect_to root_path
  end

  private
    def item_params
      params.require(:item).permit(:item_name, :item_info, :category_id, :status, :delivery_fee, :delivery_way, :area, :delivery_day, :price, :images_attributes).merge(user_id: current_user.id)
    end

    def update_item_params
      params.require(:item).permit(:item_name, :item_info, :category_id, :status, :delivery_fee, :delivery_way, :area, :delivery_day, :price, images_attributes: [:image_url,:_destroy,:id]).merge(user_id: current_user.id)
    end
    def update_item_params_without_image
      params.require(:item).permit(:item_name, :item_info, :category_id, :status, :delivery_fee, :delivery_way, :area, :delivery_day, :price).merge(user_id: current_user.id)
    end

    def comment_params
      params.require(:comment).permit(:text,:item_id).merge(user_id: current_user.id)
    end
end
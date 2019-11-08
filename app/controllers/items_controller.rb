class ItemsController < ApplicationController

  def index
    @items = Item.search(params[:search])
    @ladies_items = Item.where(category_id: 1).limit(10)
    @mens_items = Item.where(category_id: 2).limit(10)
    @appliance_items = Item.where(category_id: 8).limit(10)
    @toys_items = Item.where(category_id: 6).limit(10)
    @kubota_items = Item.where(brand_id: 1).limit(10)
    @inoue_items = Item.where(brand_id: 3).limit(10)
    @shioya_items = Item.where(brand_id: 2).limit(10)
    @tonochi_items = Item.where(brand_id: 5).limit(10)
  end

  def new
    @item = Item.new
    @item.images.build
  end


  def edit
    @item = Item.find(params[:id])
    @item.images.build
  end

  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html{redirect_to root_path}
      else
        format.html{render action: 'new'}
      end
    end
  end

  def show
  end

  def transaction
    @item = Item.find(params[:id])
    Payjp.api_key = 'sk_test_52281f87bff3f0226bcdfee1'
    charge = Payjp::Charge.create(
    :amount => @item.price,#購入する値段
    :card => params['payjp-token'],#フォームを送信すると作成・送信されてくるトークン
    :currency => 'jpy',
)
  end


  private
    def item_params
      params.require(:item).permit(:item_name, :item_info, :size, :brand_id, :status, :delivery_fee, :delivery_way, :area, :delivery_day, :price, images_attributes: {image_url: []})
    end
end
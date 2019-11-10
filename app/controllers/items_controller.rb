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
    @item = Item.find(params[:id])
  end

  def show_deleted
  end

  def bought
    @item = Item.find(params[:id])
    ken_to_name = ["--","北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県","茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県","新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県","静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    @del = "#{ken_to_name[@item.buyer.delivery.ken]} #{@item.buyer.delivery.map} #{@item.buyer.delivery.banchi} #{@item.buyer.delivery.building} #{@item.buyer.delivery.tel_number}"
  end

  def transaction
  end

  private
    def item_params
      params.require(:item).permit(:item_name, :item_info, :size, :brand_id, :status, :delivery_fee, :delivery_way, :area, :delivery_day, :price, images_attributes: {image_url: []})
    end
end
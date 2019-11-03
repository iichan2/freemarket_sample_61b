class ItemsController < ApplicationController

  def index
  end
  
  def new
    @item = Item.new
    @item.images.build
  end


  def create
    @item = Item.new(item_params)

    @item.save
   end


private

  def item_params
    params.require(:item).permit(:item_name, :item_info, :size, :brand_id, :status, :delivery_fee, :delivery_way, :area, :delivery_day, :price, images_attributes: {image_url: []})
  end
end


class ItemsController < ApplicationController

  def index
  end
  
  def new
    @item = Item.new
    @images = @item.images.build
  end


  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
          params[:images][:image_id].each do |image|
            @item.images.create(image: image, item_id: @item.id)
          end
        format.html{redirect_to root_path}
      else
        @item.images.build
        format.html{render action: 'new'}
      end
  end
end

private

  def item_params
    cate = Category.find(params(:category_id))
    params.require(:item).permit(:item_name, :item_info, :size, :brand_id, :status, :delivery_fee, :area, :delivery_day, :price, images_attributes: [:image_url]).merge(cate)
  end
end


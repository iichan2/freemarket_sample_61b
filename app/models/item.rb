class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :likes
  has_many :comments
  has_many :brands
  belongs_to :category
  has_many :images, dependent: :destroy, inverse_of: :item
  accepts_nested_attributes_for :images, allow_destroy: true

  belongs_to :user
  # belongs_to :saler, class_name: "User"
  # belongs_to :buyer, class_name: "User"

  validates :item_name, :item_info, :category_id, :status, :delivery_fee, :delivery_way, :delivery_day, :price, :area, presence: true

  validates :images, length: { in: 1..10 }
  scope :state, -> (exhibit){  where(exhibition_state: (exhibit)) }

  def self.search(item_name)
    if item_name
      Item.where(['item_name LIKE ?', "%#{item_name}%"])
    else
      Item.all
    end
  end
  
  def self.lady(num)
    lady_cate = Category.find(num)
    ladies_children = lady_cate.children
    ladies_grandchildren = []
    ladies_children.each do |lc|
      ladies_grandchildren << lc.children
    end
    lg_id = []
    ladies_grandchildren.each do |lg|
      lg.each do |lg_at|
        lg_id << lg_at.id
      end
    end
    ladys = []
    lg_id.each do |id|
      if Item.where(category_id:id).length != 0
        ladys << Item.where(category_id:id)
      end
    end
    ladies_items = []
    ladys.each do |lady|
      image = Image.find_by(item_id: lady[0].id)
      hash = {name:lady[0].item_name,id:lady[0].id,image_url:image.image_url.to_s,price:lady[0].price}
      ladies_items << hash
    end
    return ladies_items
  end

  def self.brand_item_search(brand_name)
    items = []
    same_name_brands = Brand.where(brand_name: brand_name)
    same_name_brands.each do |a_brand|
      a_item = Item.find_by(brand_id: a_brand.id)
      items << a_item
    end
    return items
  end

end

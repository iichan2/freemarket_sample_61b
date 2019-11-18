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

  # validates :item_name, :item_info, :category_id, :status, :delivery_fee, :delivery_way, :delivery_day, :price, :area, presence: true
                      #あとで追加する項目 , :saler_id,
  validates :images, length: { in: 1..10 }

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
      hash = {name:lady[0].item_name,id:lady[0].id,image_url:image.image_url,price:lady[0].price}
      ladies_items << hash
    end
    return ladies_items
  end
end

class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :likes
  has_many :comments
  belongs_to :category
  has_many :images, dependent: :destroy, inverse_of: :item
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :user
  validates :item_name, :item_info, :category_id, :status, :delivery_fee, :delivery_way, :delivery_day, :price, :area, presence: true
  validates :images, length: { in: 1..10 }
  scope :state, -> (exhibit){  where(exhibition_state: (exhibit)) }
  
  def self.get_by_category(category_parent)
    return self.where(category_id:category_parent.descendant_ids, exhibition_state:"出品中").order("created_at DESC").includes(:category,:images).take(10)
  end

  def self.get_by_brand(brand_name_string) #同名のブランドネームがテーブルに複数保存される構造になっているため
    same_name_brands = Brand.where(brand_name: brand_name_string)
    items = same_name_brands.map do |a_brand|
      a_item = self.order("created_at DESC").find_by(brand_id: a_brand.id)
    end
    return items.take(10)
  end

  def brand
    brand = Brand.find(self.brand_id)
    return brand
  end

end
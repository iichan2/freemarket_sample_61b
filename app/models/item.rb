class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :likes
  has_many :comments
  has_many :brands
  belongs_to :category
  has_many :images, inverse_of: :item
  accepts_nested_attributes_for :images
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User"

  mount_uploaders :image_url, ImageUploader
end
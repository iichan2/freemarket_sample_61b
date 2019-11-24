class Image < ApplicationRecord
  belongs_to :item
  serialize :imageurl, JSON
  mount_uploader :image_url, ImageUploader
end
class Image < ApplicationRecord
  belongs_to :item
  # mount_uploader :image_url, ImageUploader
  # serialize :imageurl, JSON

end

class Image < ApplicationRecord
  belongs_to :item
  # mount_uploaders :image_url, ImageUploader
  # serialize :imageurl, JSON
end

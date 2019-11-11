class Image < ApplicationRecord
  include ActiveModel::Model
  extend CarrierWave::Mount
  belongs_to :item
  attr_accessor :image
  mount_uploaders :image, ImageUploader

  def test(params)
    # self.image.store!(params[:image])
    self.image.cache!(params[:image])
  end
end

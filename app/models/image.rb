class Image < ApplicationRecord
  belongs_to :item
  serialize :imageurl, JSON
end
class Image < ApplicationRecord
  belongs_to :item, inverse_of: :images,optional: true
end

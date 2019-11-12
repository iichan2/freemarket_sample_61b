class Delivery < ApplicationRecord
  # has_one :user #いるかわからないので
  belongs_to :user
end

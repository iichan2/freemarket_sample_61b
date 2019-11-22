class Delivery < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  validates :kana_first_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :kana_last_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  belongs_to :user
end
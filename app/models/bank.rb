class Bank < ApplicationRecord
  validates :first_name, :last_name, :kana_first_name,  :kana_last_name , presence: ture
  validates :job, :address, :birthday, :sex, :country presence: ture
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, password_length: 7..128
  

  

  # belongs_to :card, dependent: :destroy
  # belongs_to :bank, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, through: :items
  has_many :reviews, dependent: :destroy
  has_one :delivery, dependent: :destroy
  validates :postal_code, presence: true, format: { with: /A\d{3}-\d{4}\z/}
  validates :ken, presence: true
  validates :map, presence: true
  validates :nickname, presence: true, length: { minimum: 1, maximum: 20}
  validates :email, presence: true
  validates :first_name, :last_name,  presence: true
  validates :kana_first_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :kana_last_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :tel_number, presence: true, numericality: { only_integer:true }, length: { is: 11 }    
  validates :password, presence: true, length: { minimum: 7, maximum: 128 }
  # has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  # has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  # has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"

end
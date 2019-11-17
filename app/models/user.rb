class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook google_oauth2]


  # belongs_to :card, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :nickname , presence: true
  # validates :kana_first_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  # validates :kana_last_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :tel_number, presence: true
  has_many :items 
  has_many :comments
  has_one :delivery
  has_many :cards
  # # has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  # has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  # has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"
  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = User.where(id: snscredential.user_id).first
    else
      user = User.where(email: auth.info.email).first
      if user.present?
        SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
        )
      else
        user = User.new(
          nickname: auth.info.name,
          email:    auth.info.email,
        )
        # ※user.createにすると、詳細情報が登録されずに登録される
        snscredential = SnsCredential.create(
          uid: uid,
          provider: provider
        )
      end
    end
    return { user: user, sns_id: snscredential.id }
    # ハッシュにしてsignupコントローラーに渡す
  end
end



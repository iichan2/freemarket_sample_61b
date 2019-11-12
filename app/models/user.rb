class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, password_length: 7..128
  devise :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  # belongs_to :card, dependent: :destroy
  # belongs_to :bank, dependent: :destroy
  has_one :delivery
  has_many :likes, dependent: :destroy
  has_many :comments, through: :items
  has_many :sns_credentials, dependent: :destroy
  has_many :reviews, dependent: :destroy
  # validates :postal_code, presence: true, format: { with: /A\d{3}-\d{4}\z/}
  # validates :ken, presence: true
  # validates :map, presence: true
  # validates :nickname, presence: true, length: { minimum: 1, maximum: 20}
  # validates :email, presence: true
  # validates :first_name, :last_name,  presence: true
  # validates :kana_first_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  # validates :kana_last_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  # validates :tel_number, presence: true, numericality: { only_integer:true }, length: { is: 11 }

  # validates :password, presence: true, length: { minimum: 7, maximum: 128 }
  has_many :items
  validates :password, confirmation: true
  # # has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  # has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  # has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    # binding.pry
    if snscredential.present? #sns登録のみ完了してるユーザー
      user = User.where(id: snscredential.user_id).first
      unless user.present? #ユーザーが存在しないなら
        user = User.new(
          # snsの情報
          # binding.pry => auth.infoとかで確認 
          nickname: auth.info.name,
          email: auth.info.email
        )
      end
      sns = snscredential
      #binding.pry
    else #sns登録 未
      user = User.where(email: auth.info.email).first
      if user.present? #会員登録 済
        sns = SnsCredential.new(
          uid: uid,
          provider: provider,
          user_id: user.id
        )
      else #会員登録 未
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email
        )

        sns = SnsCredential.create(
          uid: uid,
          provider: provider
        )
        # binding.pry 
      end
    end
    # hashでsnsのidを返り値として保持しておく
    return { user: user , sns_id: sns.id }
  end
end


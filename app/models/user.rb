class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  # belongs_to :card, dependent: :destroy
  # belongs_to :bank, dependent: :destroy


  validates :nickname, presence: true, length: { maximum: 20 }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  


  # validates :kana_first_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  # validates :kana_last_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  # validates :tel_number, presence: true, length: { is: 11 }, numericality: true
  has_many :items 
  has_many :comments

  # # has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  # has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  # has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    # sns = SnsCredential.update(user_id:  @user.id)
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    # binding.pry
    if snscredential.present? #sns登録のみ完了してるユーザー
      user = User.where(id: snscredential.user_id).first
      unless user.present? #ユーザーが存在しないなら
        user = User.new(
          # snsの情報
          nickname: auth.info.name,
          email: auth.info.email
        )
      end
      sns = snscredential

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
          provider: provider,
          user_id: user.id
        )
        # uid: session[:uid] 
        # @omni_user = Sns_credential.where(uid: session[:uid])
        # @omni_user.update(user_id: @user.id)
        # user.update(uid: uid, provider: privider)
      end
    end
    
    return
  end
end


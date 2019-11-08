# require 'rails_helper'
# describe User do
#   describe '#create' do
# # バリデーション
#       it "is valid with a nickname, email, password, password_confirmation, postl_code, ken, map, banchi" do
#         user = build(:user)
#         expect(user).to be_valid
#       end
# #  nick_nameがないと登録できない
#       it "is invalid without a nickname" do
#         userinfo = build(:user, nickname: nil)
#         userinfo.valid?
#         expect(userinfo.errors[:first_name]).to include("can't be blank")
#       end
# # ニックネームが２０Moji異常登録不可
#       it "is invalid without a nickname ng" do
#         user = build(:user, nickname: "a"*20)
#         user.valid?
#         expect(user.errors[:nickname][0]).to include("is too long")
#       end
# # ニックネームが２０Moji異常登録可
#       it "is invalid without a nickname ok" do
#         userinfo = build(:user_info, first_name: "a"*20)
#         expect(userinfo).to be_valid
#       end

# # email
#       it "is invalid without a email" do
#         user = build(:user, email: nil)
#         user.valid?
#         expect(user.errors[:email]).to include("can't be blank")
#       end
      
#       # メールアドレスの重複は登録不可
#     it "is invalid without a email  no mach " do
#       user = create(:user)
#       another_user = build(:user, email: user.email)
#       another_user.valid?
#       expect(another_user.errors[:email]).to include("has already been taken")
#     end
# # password
#       it "is invalid without a password" do
#         user = build(:user, password: nil)
#         user.valid?
#         expect(user.errors[:password]).to include("can't be blank")
#       end
# #  passwordが存在してもpassword_confirmation
#       it "password_confirmation and password mach" do
#         user = build(:user, password_confirmation: "")
#         user.valid?
#         expect(user.errors[:password_confirmation]).to include("パスワードが一致してません")
#       end
# #  passwordが6文字以下だと登録NG
#       it "is invalid with a password 6ijou " do
#         user = build(:user, password: "aaaaa", password_confirmation: "aaaaa")
#         user.valid?
#         expect(user.errors[:password]).to include("can't be blank")
#       end
# # passwordが7文字以上で登録OK
#       it "is valid for passwords 7 " do
#         user = build(:user, password: "aaaaaaa", password_confirmation: "aaaaaaaa")
#         expect(user).to be_valid
#       end
# # first_nameが空では登録NG
#       it "is invalid without a first_name" do
#         user = build(:user, first_name: nil)
#         user.valid?
#         expect(user.errors[:first_name]).to include("を入力してください")
#       end
  
# # last_nameが空では登録NG
#       it "is invalid without a last_name" do
#         user = build(:user, last_name: nil)
#         user.valid?
#         expect(user.errors[:last_name]).to include("を入力してください")
#       end
# # kana_first_nameが空では登録NG
#       it "is invalid without a kana_first_name" do
#         user = build(:user, kana_first_name: nil)
#         user.valid?
#         expect(user.errors[:kana_first_name]).to include("姓カナはカナ文字を入力してください")
#       end
#   # kana_first_nameカタカナで登録OK
#       it "is registration in カタカナ" do
#         user = build(:user, kana_first_name: "カタカナ")
#         expect(user).to be_valid
#       end
  
# # kana_last_nameが空では登録NG
#       it "is invalid without yes カタカナ" do
#         user = build(:user, kana_last_name: nil)
#         user.valid?
#         expect(user.errors[:kana_last_name]).to include("姓カナはカナ文字を入力してください")
#       end
#   #14 kana_last_nameカタカナで登録OK
#       it "is registration in カタカナ" do
#         user = build(:user, kana_last_name: "カタカナ")
#         expect(user).to be_valid
#       end
  
# # 電話番号が11文字だと登録OK
#       it "phone number11ok " do
#         user = build(:user, tel_number: "00000000000")
#         expect(user).to be_valid
#       end

# #郵便番号が空NG
#       it "is invalid without a postl_code" do
#         user = build(:user, postal_code: nil)
#         user.valid?
#         expect(user.errors[:postal_code]).to include("can't be blank")
#       end
  

    
#       #県名が空NG
#       it "is invalid without a ken" do
#         user = build(:user, ken: nil)
#         user.valid?
#         expect(user.errors[:ken]).to include("can't be blank")
#       end
# #市町村が空NG
#       it "is invalid without a address_city" do
#         user = build(:user, map: nil)
#         user.valid?
#         expect(user.errors[:map]).to include("can't be blank")
#       end
# #番地が空NG
#       it "is invalid without a banch" do
#         user = build(:user, banch: nil)
#         user.valid?
#         expect(user.errors[:banch]).to include("can't be blank")
#       end
  
#     end
#   end


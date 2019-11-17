class Users::RegistrationsController < Devise::RegistrationsController
  # SNS認証の際にpassword登録なしで登録できるようにする

  def create
    if params[:user][:password] == "" #sns登録なら

      params[:user][:password] = Devise.friendly_token.first(7) #deviseのパスワード自動生成機能を使用
      
      super
      sns = SnsCredential.update(user_id:  @user.id)
      
    else #email登録なら
      super
    end
  end


  private

  def user_params
    params.require(:user).permit( :nickname,
    :last_name, 
    :first_name, 
    :kana_last_name, 
    :kana_first_name,
    :l_name, 
    :f_name, 
    :kana_l_name, 
    :kana_f_name,
    :email,
    :tel_number,
    :tel_number2,
    :birth_month,
    :birth_year,
    :birth_day,
    :postal_code,
    :ken,
    :map,
    :banchi,
    :building,
    :password
    )
  end
end

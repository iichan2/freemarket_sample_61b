class UsersController < ApplicationController

  def new
   
  # session[:nickname] = user_params[:nickname]
  # session[:email] = user_params[:email]
  # session[:password] = user_params[:password]
  # session[:first_name] = user_params[:first_name]
  # session[:last_name] = user_params[:last_name]
  # session[:kana_first_name] = user_params[:kana_first_name]
  # session[:kana_last_name]= user_params[:kana_last_name]
  # session[:birth_year] = user_params[:birth_year]
  # session[:birth_month] = user_params[:birth_month]
  # session[:birth_day] = user_params[:birth_day]

  end
# sessionに渡された値をインスタンスに渡す
  def tel
    

  end
  def juusyo
    
  end
  
  def card
  end

  def ok
  end

  def show
   
  end
  # def step3
  #   session[:last_name] = user_params[:last_name]
  #   session[:first_name] = user_params[:first_name]
  #   session[:last_name_kana] = user_params[:last_name_kana]
  #   session[:first_name_kana] = user_params[:first_name_kana]
  #   @user = User.new # 新規インスタンス作成

  # end
  # def step4
    
  # end
  # def create 
  #   @user = User.new(
=======
def new
  @user = User.new
end

def show
end


  #     session[:nickname] = user_params[:nickname],
  #     session[:email] = user_params[:email],
  #     session[:password] = user_params[:password],
  #     session[:first_name] = user_params[:first_name],
  #     session[:last_name] = user_params[:last_name],
  #     session[:kana_first_name] = user_params[:kana_first_name],
  #     session[:kana_last_name]= user_params[:kana_last_name],
  #     session[:birth_year] = user_params[:birth_year],
  #     session[:birth_month] = user_params[:birth_month],
  #     session[:birth_day] = user_params[:birth_day],

  #   )
  
  # # ログインするための情報を保管
  # if @user.seve
  #   session[:id] = user.id
  #   redirect_to new_user_path(user), notice: "ユーザー登録に成功しました"
  # else
  #   render '/users/new'
  # end
  #   end

  #   # 一括登録後、自動的にサインインさせる
  # def done
  #   sign_in User.find(session[:id]) unless user_signed_in?
  # end
  # # private
  # # # Userの登録画面移行するための記述
  # # def user_params
  # #   params.require(:user).permit(
  # #     :nickname,
  # #     :email,
  # #     :password,
  # #     user_attributes:[:id, :first_name, :last_name, :kana_first_name, :kana_last_name, :birth_year, :birth_month, :birth_day]
  # #   )
  
  # # end
  
  
end

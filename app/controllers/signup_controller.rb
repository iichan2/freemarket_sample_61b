class SignupController < ApplicationController
def create
  @user = User.new(
    nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
    email: session[:email],
    password: session[:password],
    password_confirmation: session[:password_confirmation],
    last_name: session[:last_name], 
    first_name: session[:first_name], 
    kana_last_name: session[:kana_last_name], 
    kana_first_name: session[:kana_first_name], 



    l_name: session[:l_name], 
    f_name: session[:f_name], 
    kana_l_name: session[:kana_l_name], 
    kana_f_name: session[:kana_f_name], 
    birth_year: session[:birth_year],
    birth_month: session[:birth_month],
    birth_day: session[:birth_day],
    postal_code: session[:postal_code],
    ken: session[:ken],
    map: session[:map],
    banchi: session[:banchi],
    tel_number: session[:tel_number],
    tel_number2: session[:tel_number2]
  )


  if @user.save
    
  # ログインするための情報を保管
    session[:id] = @user.id

    redirect_to newend_signup_index_path

  end
end

  def mail
    # 新規登録ページ
  end

  def new
    @user = User.new
  end

  def tel
  
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:first_name] = user_params[:first_name]
    session[:last_name] = user_params[:last_name]
    session[:kana_first_name] = user_params[:kana_first_name]
    session[:kana_last_name]= user_params[:kana_last_name]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]

    @user = User.new
  
  end

# sessionに渡された値をインスタンスに渡す
  def address
    session[:tel_number] = user_params[:tel_number]
    @user = User.new
  end
  def card
    
    session[:f_name] = user_params[:first_name]
    session[:l_name] = user_params[:last_name]
    session[:kana_f_name] = user_params[:kana_first_name]
    session[:kana_l_name]= user_params[:kana_last_name]
    session[:postal_code]= user_params[:postal_code]
    session[:ken]= user_params[:ken]
    session[:map]= user_params[:map]
    session[:banchi]= user_params[:banchi]
    session[:building]= user_params[:building]
    session[:tel_number2]= user_params[:tel_number2]
    @user = User.new
  end
  def newend 
    sign_in User.find(session[:id]) unless user_signed_in?
    
    
  end
  
  private
  
  def user_params
    
    params.require(:user).permit(
      :nickname,
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
      :password,
      :password_confirmation
      )
  end


end

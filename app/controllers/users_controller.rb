class UsersController < ApplicationController
  before_action :set_params, only: [:identification,:edit, :update]
  
  def create
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana], 
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      postal_code: session[:postal_code],
      ken: session[:ken],
      map: session[:map],
      banchi: session[:banchi],
      tel_number: session[:tel_number],

      
    )
    if @user.save
    # ログインするための情報を保管
      session[:id] = @user.id
      redirect_to edit_users_path
    # else
    #   render '/signup/registration'
    end
  end
  def mail
    # ログインペーじ新規
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
  def juusyo
    session[:tel_number] = user_params[:tel_number]
    @user = User.new
  end
  def card
    session[:first_name] = user_params[:first_name]
    session[:last_name] = user_params[:last_name]
    session[:kana_first_name] = user_params[:kana_first_name]
    session[:kana_last_name]= user_params[:kana_last_name]
    session[:postal_code]= user_params[:postal_code]
    session[:ken]= user_params[:ken]
    session[:map]= user_params[:map]
    session[:banchi]= user_params[:banchi]
    session[:building]= user_params[:building]
    session[:tel_number]= user_params[:tel_number]
    @user = User.new
  end
  def ok 

    sign_in User.find(session[:id]) unless user_signed_in?
  end
  
  
  def payment
  end


def show
end

  

  def identification
    @user = User.find(params[:id])
  end

  def edit
  end

  def update    
    if @user.save
      render :edit
    else
      flash[:notice] = "入力してください"
      render :edit
    end
  end

  def logout
  end

  private
  
  def user_params
    params.permit(
      :nickname,
      :last_name, 
      :first_name, 
      :last_name_kana, 
      :first_name_kana,
      :email,
      :tel_number,
      :birth_month,
      :birth_year,
      :birth_day,
      :postal_code,
      :ken,
      :map,
      :banchi,
      :building,
      )
  end
  def set_params
    @user = User.find(params[:id])
  end
end

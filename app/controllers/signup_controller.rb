class SignupController < ApplicationController
  before_action :create_user, only: :create

  def create_user
  @info_user = session
  @user = User.new(
    nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
    email: session[:email],
    password: session[:password],
    password_confirmation: session[:password_confirmation],
    last_name: session[:last_name], 
    first_name: session[:first_name], 
    kana_last_name: session[:kana_last_name], 
    kana_first_name: session[:kana_first_name], 
    birth_year: session[:birth_year],
    birth_month: session[:birth_month],
    birth_day: session[:birth_day],
    tel_number: session[:tel_number]
  )

    if @user.save
    else
      # ログインするための情報を保管
      # notice:"USER失敗しました"
    end
  end

  def create
    # require "payjp"
      
    # Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    # if params['payjp-token'].blank?
    #   redirect_to action: "card"
    # else
    # customer = Payjp::Customer.create(
    # description: '登録テスト', #なくてもOK
    # email: @user.email, #なくてもOK
    # card: params['payjp-token'],
    # metadata: {user_id: @user.id}
    # ) #念の為metadataにuser_idを入れましたがなくてもOK
    # @card = Card.new(user_id: @user.id, customer_id: customer.id, card_id: customer.default_card)
    # @card.save
    @delivery = Delivery.new(
      first_name: @info_user[:f_name], 
      last_name: @info_user[:l_name], 
      kana_last_name: @info_user[:kana_l_name], 
      kana_first_name: @info_user[:kana_f_name], 
      postal_code: @info_user[:postal_code],
      ken: @info_user[:ken],
      map: @info_user[:map],
      banchi: @info_user[:banchi],
      tel_number: @info_user[:tel_number2],
      building: @info_user[:building],
      user_id: @user.id
    )
      
    if @delivery.save
      redirect_to root_path
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
    
    session[:f_name] = user_params[:f_name]
    session[:l_name] = user_params[:l_name]
    session[:kana_f_name] = user_params[:kana_f_name]
    session[:kana_l_name]= user_params[:kana_l_name]
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

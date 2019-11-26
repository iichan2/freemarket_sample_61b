class SignupController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :signed_in
  before_action :redirct_error_check, only: [:error_page]
  before_action :create_user, only: [:create]
  before_action :session_clear, only: [:newend]
  
  def create_user
  @user = User.new(
    nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
    email: session[:email],
    password: session[:password],
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
      if session['devise.omniauth_data']
        sns = SnsCredential.find(session[:sns_id]) 
        sns.update(user_id: @user.id)
      end
    else
    # ログインするための情報を保管
      redirect_to error_page_signup_index_path
    end
  end

  def create
    @delivery = Delivery.new(
      first_name: session[:f_name], 
      last_name: session[:l_name], 
      kana_last_name: session[:kana_l_name], 
      kana_first_name: session[:kana_f_name], 
      postal_code: session[:postal_code],
      ken: session[:ken],
      map: session[:map],
      banchi: session[:banchi],
      tel_number: session[:tel_number2],
      building: session[:building],
      user_id: @user.id
    )
    if @delivery.save
      @user.update(delivery_id: @delivery.id)
      require "payjp"
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      if payjp_params[:payjpToken].blank?
        sign_in @user 
        redirect_to error_page_cards_path
      else
        customer = Payjp::Customer.create(
        description: '登録テスト',
        email: @user.email,
        card: payjp_params[:payjpToken],
        metadata: {user_id: @user.id}
        )
        @card = Card.new(user_id: @user.id, customer_id: customer.id, card_id: customer.default_card)
        if @card.save
          sign_in @user 
          redirect_to newend_signup_index_path
        end
      end
    else
      @user.delete
      redirect_to error_page_signup_index_path
    end
  end

  def mail
    @user = User.new
  end

  def new # メールのユーザー登録画面
    @user = User.new 
  end

  def tel
    if session['devise.omniauth_data']
      # snsのデータがあれば自動生成して session[:passwodに入れる]
      session[:password] = Devise.friendly_token[0, 20] 
    else
      session[:password] = user_params[:password]
    end
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:first_name] = user_params[:first_name]
    session[:last_name] = user_params[:last_name]
    session[:kana_first_name] = user_params[:kana_first_name]
    session[:kana_last_name]= user_params[:kana_last_name]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]
    @user = User.new
  end


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
  end
  
  def error_page
  end

  private

  def signed_in
    if user_signed_in?
      redirect_to root_path
    end
  end


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
      )
  end

  def payjp_params
    params.permit(:payjpToken)
  end
end
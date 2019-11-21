class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    info = User.find_oauth(request.env["omniauth.auth"])
    # find_oauth→動かす(request.env["omniauth.auth"])取得した値を受け渡してあげないとデータがすぐに作られる
    @user = info[:user]
    session[:sns_id] = info[:sns_id]
    # 動かした結果をuser.rbに受け渡し
    if @user.persisted? #userが存在したら
      sign_in_and_redirect @user, event: :authentication 
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else#userが存在しなかったら
      session["devise.omniauth_data"] = request.env["omniauth.auth"].except("extra")
      render template: "signup/mail"
    end
  end

  def failures
    # 失敗したら
    redirect_to root_path and return
  end
end






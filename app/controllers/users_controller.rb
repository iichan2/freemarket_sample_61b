class UsersController < ApplicationController
  before_action :set_params, only: [:identification,:edit, :update]
  before_action :
  def index
  end

  def payment
  end

  def show
  end

  def identification
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
    def set_params
      @user = User.find(params[:id])
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

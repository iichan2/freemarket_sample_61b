class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.save
      render :edit
    else
      flash[:notice] = "入力してください"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname,:comments,:email,:profile)
  end
end

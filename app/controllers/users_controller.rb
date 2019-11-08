class UsersController < ApplicationController
  before_action :set_params, only: [:identification,:edit, :update]
  
  def index
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
    def set_params
      @user = User.find(params[:id])
    end
end

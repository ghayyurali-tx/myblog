class PasswordResetsController < ApplicationController

  def show
    user = User.find_by(token: params[:id])
    if user
      @token = user.token
    else
      redirect_to expired_token_path unless user
    end
  end

  def create
    user = User.find_by(token: params[:token])
    if user && user.update(password: params[:password], token: nil)
      flash[:success] = "Your password has been changed. Please sign in."
      redirect_to login_path
    elsif user
      @token = user.token
      render :show
    else
      redirect_to expired_token_path
    end
  end

end

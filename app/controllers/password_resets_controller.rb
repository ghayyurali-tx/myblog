class PasswordResetsController < ApplicationController
layout 'for_login'
  def show
    @user = User.find_by(token: params[:id])
    @token = @user.token
    if @user
      @token = @user.token
    else
      flash[:alert] = "Your reset password link has expired."
      redirect_to forgot_passwords_path unless @user
    end
    # render :show ,layout: 'for_login'
  end

  def create
     @user = User.find_by(token: params[:token])
     @token = @user.token
     # render layout: 'for_login'
    if @user && @user.update(password: params[:password],password_confirmation: params[:password_confirmation], token: nil)
      flash[:alert] = "Your password has been changed. Please sign in."
      redirect_to login_path
      else
    # if @user
    #   @token = @user.token
    #   render 'show' ,layout: 'for_login'
    redirect_to password_reset_path(@token)
    # else
    #   # redirect_to expired_token_path
    #   flash[:alert] = "Your reset password link has expired."
    #    redirect_to forgot_passwords_path
    # end
    end
    end

end

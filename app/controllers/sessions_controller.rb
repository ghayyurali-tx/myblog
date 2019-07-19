class SessionsController < ApplicationController
  layout "for_login"
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      #user.email_confirmed = true
      if user.email_confirmed
        session[:user_id] = user.id
        redirect_to user_articles_path(current_user), notice: "Logged in!"
      else
        flash.now[:alert] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
        render 'welcome/index'
      end

    else

      flash.now[:alert] = "Email or password is invalid"
      render "welcome/index"
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end

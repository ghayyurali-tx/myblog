class ForgotPasswordsController < ApplicationController
  layout 'for_login'
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.update_with_token!
      UserMailer.send_forgot_password(user).deliver
      flash[:alert] = "Check Your Email for Password Reset Instructions."
      redirect_to login_path
    else
      flash[:alert] = params[:email].blank? ? "Email cannot be blank." : "There is no user with this email address in the system."
      redirect_to forgot_passwords_path
    end
  end

end

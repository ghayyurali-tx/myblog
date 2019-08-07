class ForgotPasswordsController < ApplicationController
  layout 'for_login'
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.update_with_token!
      UserMailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "Email cannot be blank." : "There is no user this email address in the system."
      redirect_to forgot_passwords_path
    end
  end

end

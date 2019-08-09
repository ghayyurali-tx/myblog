class UserMailer < ApplicationMailer
  default :from => "emailhelper19@gmail.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")
  end

  def send_forgot_password(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Please reset your password")
    # mail to: user.email, from: "info@myflix.com", subject: "Please reset your password"
  end
end
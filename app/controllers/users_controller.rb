class UsersController < ApplicationController
   #layout "for_login", except: [:index, :confirm_email, :destroy, :show]
   #layout "users_index"
  def index

    @user = User.all
    render layout: 'users_index'

  end

  def user_new
  #render layout: "for_login"
    @user = User.new
    if current_user
    if current_user.role == 'admin'
       render layout: 'users_index'
      else
    end
    else
       render layout: "for_login"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.set_confirmation_token
      @user.save(:validate => false)
      UserMailer.registration_confirmation(@user).deliver_now
      flash[:alert] = "Please confirm your email address to continue"
      if current_user
        if current_user.role == 'admin'
          redirect_to users_path
          else
        end
        else
      redirect_to root_url
      end
    else
      if current_user
        if current_user.role == 'admin'
          render 'user_new', layout: 'users_index'
        else
        end
      else
        render 'user_new', layout: 'for_login'
      end



    end
    end


  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy

    @user = User.find(params[:id])

    @user.destroy

    redirect_to users_path
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:token])
    if user
      user.email_confirmed = true
      user.confirm_token = nil
      user.save(:validate => false)
      #flash[:alert] = "Welcome to the Sample App! Your email has been confirmed.
      #Please sign in to continue."
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
      #redirect_to login_path
    else
      flash[:alert] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end



  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end

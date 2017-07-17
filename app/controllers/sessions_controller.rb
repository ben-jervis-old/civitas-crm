class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
    @hide_sidebar = true
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to root_path
      else
        message = "Account not activated. "
        message += "Check your email for the activation link"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      @login_page = true
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_url
  end
end

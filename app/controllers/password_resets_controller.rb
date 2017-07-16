class PasswordResetsController < ApplicationController

  skip_before_action :require_login

  before_action :get_user,          only: [:edit, :update]
  before_action :valid_user,        only: [:edit, :update]
  before_action :check_expiration,  only: [:edit, :update]

  def new
    @hide_sidebar = true
  end

  def edit
    @hide_sidebar = true
  end

  def create
    @hide_sidebar = true
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Check your email for password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
			@user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @user
    end
	end

	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
        flash[:warning] = "Password reset link not valid"
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset_has_expired"
        redirect_to new_password_reset_url
      end
    end
end

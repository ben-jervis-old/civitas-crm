class AccountSetupsController < ApplicationController
  skip_before_action :require_login

  before_action :get_user,          only: [:edit, :update]
  before_action :valid_user,        only: [:edit, :update]

  def edit
    @hide_sidebar = true
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
			@user.activate if !@user.activated?
      log_in @user
			@user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @user
    end
	end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless @user && @user.authenticated?(:reset, params[:id])
        flash[:warning] = "Account setup link not valid"
        redirect_to root_url
      end
    end
end

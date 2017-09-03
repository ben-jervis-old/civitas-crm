class AccountActivationsController < ApplicationController

	skip_before_action :require_login, 	only: [:edit]

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
			notification = Notification.create(title: 'Member Activated', content: "#{user.name} has confirmed their email address.", resolve_link: user_path(user))
			notification.users << User.where(level: 'staff'))
      redirect_to root_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

end

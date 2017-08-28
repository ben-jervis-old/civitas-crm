class NotificationsController < ApplicationController
  def dismiss
		@notification = Notification.find(params[:notification_id])
		@notification.read_by(current_user.id)
		redirect_to root_path
  end
  
  def index
    @users = User.all
    @user = current_user
    @notifications = Notification.all
  end
  
  def create
  end
  
  def resolve
    notification = Notification.find(params[:notification_id])
    notification.read = true
    notification.save
		redirect_to notifications_path
  end
  
  def unresolve
    notification = Notification.find(params[:notification_id])
    notification.read = false
    notification.save
		redirect_to notifications_path
  end
  
  def create
  end
end

class NotificationsController < ApplicationController
  def dismiss
		@notification = Notification.find(params[:notification_id])
		@notification.read_by(current_user.id)
		redirect_to root_path
  end

  def index
    @staff_users =  User.where(level: %w(staff leader trusted))
                        .where("id != ?", current_user.id )
                        .select{ |user| user.notifications.where(read: false).count > 0 }

    @staff_unread = @staff_users.collect{ |user| { name: user.name, notifs: user.notifications.where(read: false).order(created_at: :desc) } }

    @unread_notifications = current_user.notifications
                                        .where(read: false)
                                        .order(created_at: :desc)
                                        .paginate(page: params[:page])

    @read_notifications = current_user.notifications
                                      .where(read: true)
                                      .order(created_at: :desc)
                                      .paginate(page: params[:page])

  end

  def resolve
    notification = Notification.find(params[:id])
    notification.read_by(current_user.id)
		redirect_to notifications_path
  end

  def unresolve
    notification = Notification.find(params[:id])
    notification.update_attributes(read: false, read_time: nil, user_id: nil)
		redirect_to notifications_path
  end
end

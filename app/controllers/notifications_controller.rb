class NotificationsController < ApplicationController
    def dismiss
			@notification = Notification.find(params[:notification_id])
			@notification.read_by(current_user.id)
			redirect_to root_path
    end
end

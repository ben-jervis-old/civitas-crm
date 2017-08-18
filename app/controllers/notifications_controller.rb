class NotificationController < ApplicationController
    def dismiss
        notification.read = true
	    notification.read_time = Time.now 
	    notification.user_id = current_user.id
	    redirect_to dashboard
    end
end
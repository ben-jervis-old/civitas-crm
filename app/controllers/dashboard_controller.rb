class DashboardController < ApplicationController
  def index
		@num_notifications = current_user.notifications.size
		@read_notifications = current_user.notifications.select(&:read)
		@unread_notifications = current_user.notifications.reject(&:read)

		@outstanding_tasks = current_user.tasks.where('due >= ?', Date.today)

		@unread_messages = current_user.received_messages.reject(&:read)
  end
end

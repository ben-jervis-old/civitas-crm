class DashboardController < ApplicationController
  def index
		@num_notifications = current_user.notifications.size
		@read_notifications = current_user.notifications.where(read: true).order(created_at: :desc)
		@unread_notifications = current_user.notifications.where(read: false).order(created_at: :desc)

		@outstanding_tasks = current_user.tasks.where('due >= ?', Date.today)

		@unread_messages = current_user.received_messages.reject(&:read)
  end
end

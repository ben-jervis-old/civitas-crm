class CreateNotificationsUsersJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :notifications, :users do |t|
    	t.index :notification_id
    	t.index :user_id
    end
  end
end

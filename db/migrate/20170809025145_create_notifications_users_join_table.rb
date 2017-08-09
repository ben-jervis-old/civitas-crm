class CreateNotificationsUsersJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :notifications, :users do |t|
    	t.index :notification_id
    	t.index :user_id
    end
    
    create_table :notification_user, id: false do |t|
      t.belongs_to :notifications, index: true
      t.belongs_to :users, index: true
    end
  end
end

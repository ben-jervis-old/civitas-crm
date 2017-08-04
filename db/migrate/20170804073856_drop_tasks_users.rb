class DropTasksUsers < ActiveRecord::Migration[5.0]
  def change
		drop_table :tasks_users
  end
end

class RenameUsersTasks < ActiveRecord::Migration[5.0]
  def change
		rename_table :users_tasks, :tasks_users
  end
end

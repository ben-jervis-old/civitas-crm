class RenameAssignmentColumns < ActiveRecord::Migration[5.0]
  def change
			rename_column :assignments, :user_id_id, :user_id
			rename_column :assignments, :task_id_id, :task_id
  end
end

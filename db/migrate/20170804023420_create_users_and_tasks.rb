class CreateUsersAndTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :users_tasks do |t|
			t.belongs_to :user, index: true
			t.belongs_to :task, index: true
    end
  end
end

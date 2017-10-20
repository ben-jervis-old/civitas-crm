class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.references :user_id, foreign_key: true
      t.references :task_id, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end

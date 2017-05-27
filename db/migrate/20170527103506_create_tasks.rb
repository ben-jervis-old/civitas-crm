class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.integer :roster_id
      t.integer :user_id
      t.string :title
      t.datetime :due
      t.string :location
      t.text :notes

      t.timestamps
    end
  end
end

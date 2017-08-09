class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :content
      t.string :resolve_link
      t.boolean :read, default: false
      t.datetime :read_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :event_date
      t.string :location
      t.integer :repeat, default: 0

      t.timestamps
    end
  end
end

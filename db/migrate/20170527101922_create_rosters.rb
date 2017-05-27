class CreateRosters < ActiveRecord::Migration[5.0]
  def change
    create_table :rosters do |t|
      t.string :title
      t.date :start_date
      t.integer :duration

      t.timestamps
    end
  end
end

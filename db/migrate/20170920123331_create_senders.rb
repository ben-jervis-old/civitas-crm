class CreateSenders < ActiveRecord::Migration[5.0]
  def change
    create_table :senders do |t|

      t.timestamps
    end
  end
end

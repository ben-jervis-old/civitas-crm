class CreateMessageReceivers < ActiveRecord::Migration[5.0]
  def change
    create_table :message_receivers do |t|

      t.timestamps
    end
  end
end

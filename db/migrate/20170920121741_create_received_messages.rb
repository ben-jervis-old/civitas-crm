class CreateReceivedMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :received_messages do |t|

      t.timestamps
    end
  end
end

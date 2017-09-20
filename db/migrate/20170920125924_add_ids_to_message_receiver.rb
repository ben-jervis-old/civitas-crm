class AddIdsToMessageReceiver < ActiveRecord::Migration[5.0]
  def change
    add_column :message_receivers, :message_id, :integer
    add_column :message_receivers, :receiver_id, :integer
  end
end

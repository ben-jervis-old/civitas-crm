class AddReceiverAndSenderIdsToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :message, :sender_id, :integer
    add_column :message, :receiver_id, :integer
  end
end

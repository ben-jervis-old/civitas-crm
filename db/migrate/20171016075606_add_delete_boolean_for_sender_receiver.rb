class AddDeleteBooleanForSenderReceiver < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :sender_delete, :boolean, default: false
    add_column :messages, :receiver_delete, :boolean, default: false
  end
end

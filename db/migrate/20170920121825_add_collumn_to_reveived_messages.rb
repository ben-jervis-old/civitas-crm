class AddCollumnToReveivedMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :received_messages, :user_id, :integer
    add_column :received_messages, :message_id, :integer
  end
end

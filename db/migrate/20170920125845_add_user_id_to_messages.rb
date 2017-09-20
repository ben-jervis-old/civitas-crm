class AddUserIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :sender_id, :integer
  end
end

class AddUserIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :recipients_id, :integer
    add_column :users, :received_id, :integer
  end
end

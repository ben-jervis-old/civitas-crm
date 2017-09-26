class AddReceiverIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :receiver_id, :integer
  end
end

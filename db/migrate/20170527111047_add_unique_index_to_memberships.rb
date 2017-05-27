class AddUniqueIndexToMemberships < ActiveRecord::Migration[5.0]
  def change
		add_index :memberships, [:user_id, :group_id], unique: true
  end
end

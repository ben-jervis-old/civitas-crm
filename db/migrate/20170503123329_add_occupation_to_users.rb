class AddOccupationToUsers < ActiveRecord::Migration[5.0]
  def change
		add_column :users, :occupation, :string
		add_column :users, :notes, :text
  end
end

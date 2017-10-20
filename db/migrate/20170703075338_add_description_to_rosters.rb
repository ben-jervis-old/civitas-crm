class AddDescriptionToRosters < ActiveRecord::Migration[5.0]
  def change
    add_column :rosters, :description, :text
  end
end

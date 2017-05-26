class FixGroupColumnName < ActiveRecord::Migration[5.0]
  def change
		rename_column :groups, :type, :group_type
  end
end

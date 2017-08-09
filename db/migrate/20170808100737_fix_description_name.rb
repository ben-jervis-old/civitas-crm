class FixDescriptionName < ActiveRecord::Migration[5.0]
  def change
    rename_column :groups, :discription, :description
  end
end

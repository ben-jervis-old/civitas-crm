class AddDescriptionToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :discription, :string
  end
end
  
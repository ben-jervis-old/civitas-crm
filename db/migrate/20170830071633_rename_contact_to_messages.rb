class RenameContactToMessages < ActiveRecord::Migration[5.0]
  def self.up
    rename_table :contacts, :messages
  end

  def self.down
    rename_table :messages, :contacts
  end
end

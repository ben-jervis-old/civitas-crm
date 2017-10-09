class AddDefaultValueToMessagesSent < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:messages, :sent, 'false')
  end
end

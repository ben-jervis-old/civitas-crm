class AddUserCreatedAtToPrivacySetting < ActiveRecord::Migration[5.0]
  def change
    add_column :privacy_settings, :user_created_at, :boolean, default: true
  end
end

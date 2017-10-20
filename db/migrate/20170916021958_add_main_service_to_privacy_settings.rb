class AddMainServiceToPrivacySettings < ActiveRecord::Migration[5.0]
  def change
    add_column :privacy_settings, :main_service, 	:boolean, default: true
		add_column :privacy_settings, :occupation, 		:boolean, default: false
  end
end

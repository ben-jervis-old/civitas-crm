class ChangePrivacyFields < ActiveRecord::Migration[5.0]
  def change
		change_table :privacy_settings do |t|
			t.rename :phone_number, :mobile_number
			t.boolean :home_number, default: true
			t.boolean :work_number, default: true
		end
  end
end

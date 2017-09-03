class ChangePhoneNumberFields < ActiveRecord::Migration[5.0]
  def change
		change_table :users do |t|
			t.rename :phone_number, :mobile_number
			t.integer :home_number
			t.integer :work_number
		end
  end
end

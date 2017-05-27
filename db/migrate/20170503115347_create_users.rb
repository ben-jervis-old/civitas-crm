class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :phone_number
      t.string :address
      t.string :email
      t.date :dob
      t.string :password_digest
      t.string :level
      t.boolean :privacy_consent
      t.string :main_service
      t.text :special_needs

      t.timestamps
    end
  end
end

class CreatePrivacySettings < ActiveRecord::Migration[5.0]
  def change
    create_table :privacy_settings do |t|
      t.references :user, foreign_key: true
      t.boolean :presence,			default: true
      t.boolean :phone_number,	default: true
      t.boolean :address,			default: true
      t.boolean :email,				default: true
      t.boolean :dob,					default: true

      t.timestamps
    end
  end
end

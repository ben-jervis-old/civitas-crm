class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :title
      t.text :content
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :sent_at
      t.boolean :sent, default: false

      t.timestamps
    end
  end
end

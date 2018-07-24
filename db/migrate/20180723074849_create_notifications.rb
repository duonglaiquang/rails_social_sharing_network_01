class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :sender_id
      t.integer :post_id
      t.string :notice_type
      t.boolean :seen, default: false
      t.timestamps
    end
  end
end

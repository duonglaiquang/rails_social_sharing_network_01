class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.string :target_type
      t.integer :target_id
      t.integer :user_id
      t.integer :vote_type
      t.integer :favorite
      t.timestamps
    end
  end
end

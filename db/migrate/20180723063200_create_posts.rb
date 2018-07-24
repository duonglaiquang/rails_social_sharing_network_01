class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.integer :user_id
      t.integer :tag_id
      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end

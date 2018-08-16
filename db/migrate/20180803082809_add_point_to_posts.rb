class AddPointToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :point, :integer
    add_column :posts, :upload_type, :integer, default: 0
  end
end

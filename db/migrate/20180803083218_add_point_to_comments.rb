class AddPointToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :point, :integer, default: 0
  end
end

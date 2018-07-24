class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.text :reason
      t.text :url
      t.timestamps
    end
  end
end

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :place, null: false
      t.string :schedule, null: false
      t.text :body, null: false
      t.string :contact, null: false

      t.timestamps
    end
  end
end

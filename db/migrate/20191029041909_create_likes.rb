class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer       :user_id, null: false 
      t.integer       :item_id, null: false
      t.timestamps
    end
    add_foreign_key :likes, :users 
    add_foreign_key :likes, :items
  end
end

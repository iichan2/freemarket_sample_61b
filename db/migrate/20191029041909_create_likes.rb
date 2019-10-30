class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_reference :likes, :item, foreign_key: true
  end
end
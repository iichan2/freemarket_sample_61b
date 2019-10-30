class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references "user_id", foreign_key: true
      t.references "item_id", foreign_key: true
      t.text    "text"   , null: false
      t.timestamps
    end
  end
end

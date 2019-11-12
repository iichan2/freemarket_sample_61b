class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_name, null: false
      t.text :item_info, null: false
      t.references :category, foreign_key: true
      t.string :size
      t.string :status, null: false
      t.string :delivery_fee, null: false
      t.string :delivery_way, null: false
      t.string :area, null: false
      t.string :delivery_day, null: false
      t.integer :price, null: false
      t.integer :user_id
      t.integer :buyer_id
      t.string :exhibition_state
      t.timestamps
    end
    add_reference :items, :brand, foreign_key: true
  end
end

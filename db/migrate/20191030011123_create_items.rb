class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string "item_name", null: false
      t.text "item_info", null: false
      t.integer "category_id", null: false
      t.string "size"
      t.integer "brand_id"
      t.string "status", null: false
      t.string "delivery_fee", null: false
      t.string "delivery_way", null: false
      t.string "area", null: false
      t.string "delivery_day", null: false
      t.integer "price", null: false
      t.integer "saler_id"
      t.integer "buyer_id"
      t.timestamps
    end
  end
end

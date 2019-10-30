class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer "user_id", null: false
      t.integer "item_id", null: false
      t.text "good"
      t.text "normal"
      t.text "bad"
      t.timestamps
    end
  end
end

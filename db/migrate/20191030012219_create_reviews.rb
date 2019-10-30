class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references "user_id", foreign_key: true
      t.references "item_id", foreign_key: true
      t.text "good"
      t.text "normal"
      t.text "bad"
      t.timestamps
    end
  end
end

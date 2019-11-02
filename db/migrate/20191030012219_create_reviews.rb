class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.text :good
      t.text :normal
      t.text :bad
      t.timestamps
    end
    add_reference :reviews, :item, foreign_key: true
  end
end

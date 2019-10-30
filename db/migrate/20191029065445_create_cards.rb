class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references       :user, foreign_key: true
      t.integer          :customer_code, null: false
      t.integer          :expiration_year, null: false
      t.integer          :expiration_mon, nulll: false
      t.integer          :card_code, null: false
      t.timestamps
    end
  end
end
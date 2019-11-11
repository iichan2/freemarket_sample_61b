class AddColumnCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :customer_id, :string , null: false
    add_column :cards, :card_id, :string, null: false
  end
end

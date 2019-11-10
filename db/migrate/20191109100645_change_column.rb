class ChangeColumn < ActiveRecord::Migration[5.2]
  def up
    add_column :cards, :customer_code, :string , null: false
    add_column :cards, :card_code, :string, null: false
  end

  # 変更前の状態
  def down
    add_column :cards, :customer_code, :integer , null: false
    add_column :cards, :card_code, :integer, null: false
  end

end

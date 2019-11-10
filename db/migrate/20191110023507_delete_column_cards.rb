class DeleteColumnCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :customer_code, :integer
    remove_column :cards, :card_code, :integer
  end
end

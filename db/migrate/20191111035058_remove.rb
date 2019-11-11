class Remove < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :customer_code, :indeger
    remove_column :cards, :expiration_year, :indeger
    remove_column :cards, :expiration_mon, :integer
    remove_column :cards, :card_code, :integer
  end
end

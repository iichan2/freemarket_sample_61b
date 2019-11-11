class Change < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :expiration_year, :integer
    remove_column :cards, :expiration_mon, :integer
  end
end

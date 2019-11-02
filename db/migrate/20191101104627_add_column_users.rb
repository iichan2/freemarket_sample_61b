class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :postal_code, :integer
    add_column :users, :ken, :integer
    add_column :users, :map, :string
    add_column :users, :banchi, :integer
    add_column :users, :building , :string


  end
end

class AddColumnUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :f_name, :string
    add_column :users, :l_name, :string
    add_column :users, :kana_f_name, :string
    add_column :users, :kana_l_name, :string
    add_column :users, :keyword, :string
    add_column :users, :keyword2, :string


    
  end
end

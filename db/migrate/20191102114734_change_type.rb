class ChangeType < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :ancestry, :string
  end
end

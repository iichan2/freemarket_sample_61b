class ChangeBrand < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :brand_group, :string
  end
end

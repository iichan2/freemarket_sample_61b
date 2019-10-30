class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string "category"
      t.integer "ancetory"
      t.timestamps
    end
  end
end

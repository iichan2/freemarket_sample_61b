class CreateBrandes < ActiveRecord::Migration[5.2]
  def change
    create_table :brandes do |t|
      t.string "brand_name"
      t.timestamps
    end
  end
end

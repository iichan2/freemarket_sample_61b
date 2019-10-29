class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.string :first_name
      t.string :last_name
      t.string :kana_first_name 
      t.string :kana_last_name
      t.string :job
      t.string :address
      t.string :birthday
      t.string :sex
      t.string :country
      t.timestamps
    end
  end
end

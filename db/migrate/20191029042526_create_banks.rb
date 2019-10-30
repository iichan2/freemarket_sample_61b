class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.string           :first_name, null: false
      t.string           :last_name, null: false
      t.string           :kana_first_name, null: false
      t.string           :kana_last_name, null: false
      t.string           :bank_name, null: false
      t.string           :job, null: false
      t.string           :address, null: false
      t.string           :birthday, null: false
      t.string           :sex, null: false
      t.string           :country, null: false
      t.references       :user, foreign_key: true
      t.timestamps
    end
  end
end

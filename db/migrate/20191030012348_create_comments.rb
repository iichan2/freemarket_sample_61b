class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.text    :text   
      t.timestamps
    end
    add_reference :comments, :item, foreign_key: true
  end
end

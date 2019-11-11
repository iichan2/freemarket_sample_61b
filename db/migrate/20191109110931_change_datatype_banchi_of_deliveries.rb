class ChangeDatatypeBanchiOfDeliveries < ActiveRecord::Migration[5.2]
  def change
    change_column :deliveries, :banchi, :string, null: false
  end
end

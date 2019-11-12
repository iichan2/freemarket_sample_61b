require 'csv'
default_items = CSV.read('./db/items/default_items.csv', headers: true)

hashs = []
default_items.each do |data|
  hash = {
    item_name:"#{data["item_name"]}",
    item_info:"#{data["item_info"]}",
    category_id:"#{data["category_id"]}",
    size:"#{data["size"]}",
    status:"#{data["status"]}",
    delivery_fee:"#{data["delivery_fee"]}",
    delivery_way:"#{data["delivery_way"]}",
    area:"#{data["area"]}",
    delivery_day:"#{data["delivery_day"]}",
    price:"#{data["price"]}",
    saler_id:"#{data["saler_id"]}",
    buyer_id:"#{data["buyer_id"]}",
    exhibition_state:"#{data["exhibition_state"]}",
    
    brand_id:"#{data["brand_id"]}"}

  hashs << hash
end

Item.create!(hashs)
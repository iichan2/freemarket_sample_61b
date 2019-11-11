FactoryBot.define do

  factory :item do
    id                     {1}
    item_name              {"neko"}
    item_info              {"nekoneko"}
    category_id            {2}
    size                   {"X"}
    status                 {"新品、未使用"}
    delivery_fee           {"送料込み (出品者負担)"}
    delivery_way           {"クロネコヤマト"}
    delivery_day           {"1~2日で発送"}
    price                  {5000}
    area                   {"北海道"}
    saler_id               {1}
    buyer_id               {2}
    brand_id               {2}
  end

end
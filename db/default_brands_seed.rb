require 'csv'
default_brands = CSV.read('./db/brand/default_brands.csv',headers: true)

hashs = []
default_brands.each do |data|
  hash = {brand_name:"#{data["brand_name"]}",brand_group:"#{data["brand_group"]}"}
  hashs << hash
end

Brand.create!(hashs)
require 'csv'
default_images_url = CSV.read('./db/images/default_images_url.csv',headers: true)

hashs = []
default_images_url.each do |data|
  hash = {
    image_url:"#{data["image_url"]}",
    item_id:"#{data["item_id"]}"
  }
  hashs << hash
end

Image.create!(hashs)
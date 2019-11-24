# 自動生成用
# require './db/generate_seeds/CSV_to_ancestry.rb'
# Ancestry_seeds.new
require './db/created.rb'
require './db/default_brands_seed.rb'
require 'faker'

users = []
user = {
  first_name: Faker::Name.last_name,
  last_name: Faker::Name.first_name,
  kana_first_name: "シンゾウ",
  kana_last_name: "アベ",
  nickname: Faker::Games::Pokemon.name,
  tel_number: "08012345678",
  delivery_id: 1,
  # likes: Faker::String.random(length: 4),
  # comments: Faker::String.random(length: 4),
  # reviews: Faker::String.random(length: 4),
  password: "1234567",
  # password_confirmation: "1234567",
  birth_year: Faker::Number.between(from: 1900, to: 2019), 
  birth_month: Faker::Number.between(from: 1, to: 12), 
  birth_day: Faker::Number.between(from: 1, to: 31), 
  # profile: Faker::String.random(length: 4), 
  email: "test@gmail.com",
  provider: "1w",
  uid: "1s"
}
users << user
49.times() do 
  user = {
    first_name: Faker::Name.last_name,
    last_name: Faker::Name.first_name,
    kana_first_name: "シンゾウ",
    kana_last_name: "アベ",
    nickname: Faker::Games::Pokemon.name,
    tel_number: "08012345678",
    delivery_id: 1,
    # likes: Faker::String.random(length: 4),
    # comments: Faker::String.random(length: 4),
    # reviews: Faker::String.random(length: 4),
    password: "1234567",
    # password_confirmation: "1234567",
    birth_year: Faker::Number.between(from: 1900, to: 2019), 
    birth_month: Faker::Number.between(from: 1, to: 12), 
    birth_day: Faker::Number.between(from: 1, to: 31), 
    # profile: Faker::String.random(length: 4), 
    email: Faker::Internet.email,
    provider: "1w",
    uid: "1s"
  }
  users << user
end

User.create!(users)

num = 1
50.times() do
  Delivery.create!(
    first_name: "安倍",
    last_name: "晋三",
    kana_first_name: "アベ",
    kana_last_name: "シンゾウ",
    postal_code: "123-4567",
    ken: 5,
    map: "東京都",
    banchi: "123-2",
    building: "梅田ビル",
    tel_number: "080-1234-5678",
    user_id: num,
  )
  num += 1
end

# require './db/default_items_seed.rb'
# require './db/default_images_url_seed.rb'
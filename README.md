# README

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false |
|last_name|string|null: false |
|kana_first_name|string|null: false |
|kana_last_name|string|null: false |
|email|string|null: false |
|password|string|null: false |
|birthday|string|null: false|
|tel_number|string|null: false |
|nickname|string|
|profile|text|
### Association
-has_one :card
-has_one :bank
-has_many :likes
-has_many :comments
-has_many :reviews
-has_one :delivery
<!-- 現在売っている商品,買った商品、既に売った商品を取り出せるようにしている -->
-has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
-has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
-has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"

## deliveries
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false |
|last_name|string|null: false |
|kana_first_name|string|null: false |
|kana_last_name|string|null: false |
|postal_code|integer|null: false |
|ken|integer|null: false |
|map|string|null: false |
|banchi|integer|null: false |
|building|string|
|tel_number|string|
|user_id|integer|null: false |
### Association
-belongs_to :user


## cards
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false |
|customer_code|integer|null: false |
|expiration_year|integer|null: false 
|expiration_mon|integer|null: false |
|card_code|integer|null: false |
### Association
-belongs_to :user


## images
|Column|Type|Options|
|------|----|-------|
|image_url|text|null: false|
|item_id|integer|null: false|
### Association
-belongs_to :item


## items
|Column|Type|Options|
|------|----|-------|
|item_name|string|null: false |
|item_info|text|null: false |
|category_id|integer|null: false |
|size|string|
|brand_id|integer|
|status|string|null: false |
|delivery_fee|string|null: false|
|delivery_way|string|null: false|
|area|string|null: false|
|delivery_day|string|null: false|
|price|integer|null: false|
|saler_id|integer|
|buyer_id|integer|
### Association
-has_many :likes
-has_many :comments
-belongs_to :brand
-belongs_to :category
-has_many :images
-has_many :reviews
<!-- 購入者、出品者を取り出せるようにしている -->
-belongs_to :saler, class_name: "User"
-belongs_to :buyer, class_name: "User"


## categories
|Column|Type|Options|
|------|----|-------|
|category|string|
|ancestry|integer|
### Association
-has_many :items
-has_ancestry


## brandes
|Column|Type|Options|
|------|----|-------|
|brand_name|string|
### Association
-has_many :items


## reviews
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false |
|item_id|integer|null: false |
|good|text|
|normal|text|
|bad|text|
### Association
-belongs_to :user
-belongs_to :item


## comments
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false |
|item_id|integer|null: false |
|text|text|null: false |
### Association
-belongs_to :user
-belongs_to :item

## banks
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false |
|last_name|string|null: false |
|kana_first_name|string|null: false |
|kana_last_name|string|null: false |
|bank_name|string|null: false |
|job|string|null: false |
|address|string|null: false |
|birthday|string|null: false |
|sex|string|null: false |
|country|string|null: false |
### Association
-belongs_to :user

## likes
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false |
|item_id|integer|null: false |
### Association
-belongs_to :item
-belongs_to :user

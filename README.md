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
|birthday|datetime|null: false|
|tel_number|string|null: false |
|profile|text|
|nickname|string|null: false |
### Association
-has_one :card
-has_one :bank
-has_many :likes
-has_many :comments
-has_many :reviews
-has_one :deliverys
<!-- 現在売っている商品,買った商品、既に売った商品を取り出せるようにしている -->
-has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
-has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
-has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"

## deliverys
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false |
|last_name|string|null: false |
|kana_first_name|string|null: false |
|kana_last_name|string|null: false |
|postal_code|integer|null: false |
|ken|string|null: false |
|map|string|null: false |
|banchi|integer|null: false |
|building|string|
|tel_number|integer|
|users_id|integer|null: false |
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
|items_id|text|null: false|
### Association
-belongs_to :item


## items
|Column|Type|Options|
|------|----|-------|
|item_name|integer|null: false |
|item_info|text|null: false |
|image_id|text|null: false|
|category_id|string|null: false |
|size|string|
|brand_id|string|
|status|string|null: false |
|delivery_fee|string|null: false|
|delivery_way|string|null: false|
|area|string|null: false|
|delivery_day|string|null: false|
|price|integer|null: false|
|comment_id|text|
|saler_id|integer|
|buyer_id|integer|
### Association
-has_many :likes
-has_many :comments
-has_many :brands
-belongs_to :category
-has_many :images
<!-- 購入者、出品者を取り出せるようにしている -->
-belongs_to :saler, class_name: "User"
-belongs_to :buyer, class_name: "User"

## categorys
|category|string|

### Association
-has_many :item
-has_ancestry



##　brands
|brand_name|string|
### Association
-belongs_to :item


## reviews
|user_id|integer|null: false |
|item_id|text|null: false |
|good|text|
|normal|text|
|but|text|
### Association
-belongs_to :user
-belongs_to :item


## comments
|user_id|integer|null: false |
|item_id|text|null: false |
|text|text|null: false |
### Association
-belongs_to :user
-belongs_to :item

## banks
|first_name|string|null: false |
|last_name|string|null: false |
|kana_first_name|string|null: false |
|kana_last_name|string|null: false |
|bank_name|string|null: false |
|job|string|null: false |
|address|string|null: false |
|birthday|datetime|null: false |
|sex|string|null: false |
|Country|string|null: false |
### Association
-belongs_to :user

## likes
|user_id|integer|null: false |
|item_id|text|null: false |
### Association
-belongs_to :item
-belongs_to :user



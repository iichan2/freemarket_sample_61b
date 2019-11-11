require 'rails_helper'
describe Item do
  describe '#create' do
    it "全てあれば保存できる" do
      item = build(:item)
      expect(item).to be_valid


    end
    it "サイズの必要性" do
      item = build(:item, size: nil)
      expect(item).to be_valid

    end

    it "ブランドの必要性" do
      item = build(:item, brand_id: nil)
      expect(item).to be_valid
    end

    it "名前の必要性" do
      item = build(:item, item_name: nil)
      expect(item).to be_valid
    end

    it "アイテム説明の必要性" do
      item = build(:item, item_info: nil)
      expect(item).to be_valid
      # item.valid?
      # expect(item.errors[:item_name]).to include("が足りません")
    end

    it "状態の必要性" do
      item = build(:item, status: nil)
      expect(item).to be_valid
    end
    it "発送料支払者の必要性" do
      item = build(:item, delivery_fee: nil)
      expect(item).to be_valid
    end

    it "発送方法の必要性" do
      item = build(:item, delivery_way: nil)
      expect(item).to be_valid
    end

    it "発送時間の必要性" do
      item = build(:item, delivery_day: nil)
      expect(item).to be_valid
    end

    it "発送地域の必要性" do
      item = build(:item, area: nil)
      expect(item).to be_valid
    end

    it "買い手の必要性" do
      item = build(:item, saler_id: nil)
      expect(item).to be_valid
    end

    it "売り手の必要性" do
      item = build(:item, buyer_id: nil)
      expect(item).to be_valid
    end

  end
end




require 'rails_helper'
describe Item do
  describe '#create' do
    it "全てあれば保存できる" do
      item = build(:item)
      expect(item).to be_valid


    end
    it "サイズは不必要" do
      item = build(:item, size: nil)
      expect(item).to be_valid

    end

    it "ブランドは不必要" do
      item = build(:item, brand_id: nil)
      expect(item).to be_valid
    end

    it "名前は必要" do
      item = build(:item, item_name: nil)
      item.valid?
      expect(item.errors[:item_name]).to include("can't be blank")
    end

    it "アイテム説明は必要" do
      item = build(:item, item_info: nil)
      item.valid?
      expect(item.errors[:item_info]).to include("can't be blank")
    end

    it "状態は必要" do
      item = build(:item, status: nil)
      item.valid?
      expect(item.errors[:status]).to include("can't be blank")
    end
    it "発送料支払者は必要" do
      item = build(:item, delivery_fee: nil)
      item.valid?
      expect(item.errors[:delivery_fee]).to include("can't be blank")
    end

    it "発送方法は必要" do
      item = build(:item, delivery_way: nil)
      item.valid?
      expect(item.errors[:delivery_way]).to include("can't be blank")
    end

    it "発送時間は必要" do
      item = build(:item, delivery_day: nil)
      item.valid?
      expect(item.errors[:delivery_day]).to include("can't be blank")
    end

    it "発送地域は必要" do
      item = build(:item, area: nil)
      item.valid?
      expect(item.errors[:area]).to include("can't be blank")
    end

    it "買い手は必要" do
      item = build(:item, saler_id: nil)
      item.valid?
      expect(item.errors[:saler_id]).to include("can't be blank")
    end

    it "売り手は不必要" do
      item = build(:item, buyer_id: nil)
      expect(item).to be_valid
    end

  end
end




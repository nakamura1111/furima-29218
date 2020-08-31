require 'rails_helper'

RSpec.describe Good, type: :model do
  before do
    @good = FactoryBot.build(:good)
    @good.image = fixture_file_upload("public/images/camera.png")
  end
  describe '商品情報の保存の可否' do
    # name
    it 'nameが空だと登録できない' do
      @good.name = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Name can't be blank")
    end
    it 'nameが41文字以上だと登録できない' do
      @good.name = Faker::Lorem.paragraph_by_chars(number: 41)
      @good.valid?
      expect(@good.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
    end
    # description
    it 'descriptionが空だと登録できない' do
      @good.description = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Description can't be blank")
    end
    it 'descriptionが1001文字以上だと登録できない' do
      @good.description = Faker::Lorem.paragraph_by_chars(number: 1001)
      @good.valid?
      expect(@good.errors.full_messages).to include("Description is too long (maximum is 1000 characters)")
    end
    # category
    it 'category_idが1だと登録できない' do
      @good.category_id = Category.first.id
      @good.valid?
      expect(@good.errors.full_messages).to include("Category must be other than 1")
    end
    # status
    it 'status_idが1だと登録できない' do
      @good.status_id = GoodStatus.first.id
      @good.valid?
      expect(@good.errors.full_messages).to include("Status must be other than 1")
    end
    # origin_prefecture
    it 'origin_prefecture_idが1だと登録できない' do
      @good.origin_prefecture_id = Prefecture.first.id
      @good.valid?
      expect(@good.errors.full_messages).to include("Origin prefecture must be other than 1")
    end
    # delivery_days
    it 'delivery_days_idが1だと登録できない' do
      @good.delivery_days_id = DeliveryDay.first.id
      @good.valid?
      expect(@good.errors.full_messages).to include("Delivery days must be other than 1")
    end
    # fee_charger
    it 'fee_charger_idが1だと登録できない' do
      @good.fee_charger_id = FeeCharger.first.id
      @good.valid?
      expect(@good.errors.full_messages).to include("Fee charger must be other than 1")
    end
    # price
    it 'priceが空だと登録できない' do
      @good.price = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceに数字以外が入ると登録できない' do
      @good.price = 'sample123'
      @good.valid?
      expect(@good.errors.full_messages).to include("Price is not a number")
    end
    it 'priceが299だと登録できない' do
      @good.price = 299
      @good.valid?
      expect(@good.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
    it 'priceが300だと登録できる' do
      @good.price = 300
      @good.valid?
      expect(@good).to be_valid
    end
    it 'priceが9,999,999だと登録できる' do
      @good.price = 9999999
      @good.valid?
      expect(@good).to be_valid
    end
    it 'priceが10,000,000だと登録できない' do
      @good.price = 10000000
      @good.valid?
      expect(@good.errors.full_messages).to include("Price must be less than 10000000")
    end
    # user
    it 'userが紐づいていないと登録できない' do
      @good.user = nil
      @good.valid?
      expect(@good.errors.full_messages).to include("User must exist")
    end
    # 正常
    it 'すべてのデータがバリデーションの範囲内ならば登録できる' do
      expect(@good).to be_valid
    end
  end
end

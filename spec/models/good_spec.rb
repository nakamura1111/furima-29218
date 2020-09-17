require 'rails_helper'

RSpec.describe Good, type: :model do
  before do
    @good = FactoryBot.build(:good)
  end
  describe '商品情報の保存の可否' do
    context '商品名(name)を登録できないとき' do
      it '空だと登録できない' do
        @good.name = nil
        @good.valid?
        expect(@good.errors.full_messages).to include('商品名を入力してください')
      end
      it '41文字以上だと登録できない' do
        @good.name = Faker::Lorem.paragraph_by_chars(number: 41)
        @good.valid?
        expect(@good.errors.full_messages).to include('商品名は40文字以内で入力してください')
      end
    end
    context '商品の概要(description)を登録できないとき' do
      it '空だと登録できない' do
        @good.description = nil
        @good.valid?
        expect(@good.errors.full_messages).to include('商品の説明を入力してください')
      end
      it '1001文字以上だと登録できない' do
        @good.description = Faker::Lorem.paragraph_by_chars(number: 1001)
        @good.valid?
        expect(@good.errors.full_messages).to include('商品の説明は1000文字以内で入力してください')
      end
    end
    context '商品カテゴリを登録できないとき' do
      it 'category_idが1だと登録できない' do
        @good.category_id = Category.first.id
        @good.valid?
        expect(@good.errors.full_messages).to include('商品のカテゴリーを選択してください')
      end
    end
    context '商品の状態を登録できないとき' do
      it 'status_idが1だと登録できない' do
        @good.status_id = GoodStatus.first.id
        @good.valid?
        expect(@good.errors.full_messages).to include('商品の状態を選択してください')
      end
    end
    context '発送元の地域を登録できないとき' do
      it 'origin_prefecture_idが1だと登録できない' do
        @good.origin_prefecture_id = Prefecture.first.id
        @good.valid?
        expect(@good.errors.full_messages).to include('発送元の地域を選択してください')
      end
    end
    context '発送までの日数を登録できないとき' do
      it 'delivery_days_idが1だと登録できない' do
        @good.delivery_days_id = DeliveryDay.first.id
        @good.valid?
        expect(@good.errors.full_messages).to include('発送までの日数を選択してください')
      end
    end
    context '配送料の負担者を登録できないとき' do
      it 'fee_charger_idが1だと登録できない' do
        @good.fee_charger_id = FeeCharger.first.id
        @good.valid?
        expect(@good.errors.full_messages).to include('配送料の負担者を選択してください')
      end
    end
    context 'priceを登録できないとき' do
      it 'priceが空だと登録できない' do
        @good.price = nil
        @good.valid?
        expect(@good.errors.full_messages).to include('販売価格を入力してください')
      end
      it 'priceに数字以外が入ると登録できない' do
        @good.price = Faker::Alphanumeric.alphanumeric(number: 7, min_alpha: 1)
        @good.valid?
        expect(@good.errors.full_messages).to include('販売価格に半角数字のみで記入してください')
      end
      it 'priceが整数でない場合、登録できない' do
        @good.price = Faker::Number.decimal(l_digits: 7, r_digits: 4)
        @good.valid?
        expect(@good.errors.full_messages).to include('販売価格は整数で入力してください')
      end
      it 'priceが299だと登録できない' do
        @good.price = 299
        @good.valid?
        expect(@good.errors.full_messages).to include('販売価格は300以上の値にしてください')
      end
      it 'priceが10,000,000だと登録できない' do
        @good.price = 10_000_000
        @good.valid?
        expect(@good.errors.full_messages).to include('販売価格は10000000より小さい値にしてください')
      end
    end
    context 'priceを登録できるとき' do
      it 'priceが300だと登録できる' do
        @good.price = 300
        expect(@good).to be_valid
      end
      it 'priceが9,999,999だと登録できる' do
        @good.price = 9_999_999
        expect(@good).to be_valid
      end
    end
    context 'user_idを登録できるとき' do
      it 'userが紐づいていないと登録できない' do
        @good.user = nil
        @good.valid?
        expect(@good.errors.full_messages).to include('Userを入力してください')
      end
    end
    context '出品画像を登録できるとき' do
      it 'imageが紐づいていないと登録できない' do
        @good.images = nil
        @good.valid?
        expect(@good.errors.full_messages).to include('出品画像を入力してください')
      end
    end
    context '登録できるとき' do
      it 'すべてのデータがバリデーションの範囲内ならば登録できる' do
        expect(@good).to be_valid
        goods = FactoryBot.create_list(:good, 30)
        goods.each { |good| expect(good).to be_valid }
      end
    end
  end
end

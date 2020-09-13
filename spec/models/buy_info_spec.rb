require 'rails_helper'

RSpec.describe 'BuyInfoモデル', type: :model do
  before do
    @buy_info = FactoryBot.build(:buy_info)     # factorybotにassociation記述しておくと紐づいて自動的に生成される。
  end
  describe 'バリデーションの調査' do
    # 正常
    context '登録できるとき' do
      it 'バリデーションができていれば登録できる' do
        expect(@buy_info).to be_valid
      end
      it '住所（建物・部屋番号）がなくても登録できる' do
        @buy_info.addr_building = nil
        expect(@buy_info).to be_valid
      end
    end
    # postal_code
    context '郵便番号が登録できないとき' do
      it '空だと登録できない' do
        @buy_info.postal_code = nil
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '数字の桁数が違うと登録できない' do
        @buy_info.postal_code = "#{Faker::Number.number(digits: 2)}-#{Faker::Number.number(digits: 4)}"
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("郵便番号の入力を確認してください")
        @buy_info.postal_code = "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 5)}"
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("郵便番号の入力を確認してください")
      end
      it 'ハイフンがないと登録できない' do
        @buy_info.postal_code = "#{Faker::Number.number(digits: 3)}#{Faker::Number.number(digits: 4)}"
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("郵便番号の入力を確認してください")
      end
      it '数字以外があると登録できない' do
        @buy_info.postal_code = Faker::Lorem.paragraph_by_chars(number: 8)
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("郵便番号の入力を確認してください")
      end
    end
    # address(prefecture)
    context '住所（都道府県）が登録できないとき' do
      it 'id が 1 だと登録できない' do
        @buy_info.addr_prefecture_id = Prefecture.first.id
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("都道府県を選択してください")
      end
    end
    # address(municipality)
    context '住所（市町村区）が登録できないとき' do
      it '空だと登録できない' do
        @buy_info.addr_municipality = nil
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("市区町村を入力してください")
      end
    end
    # address(house_number)
    context '住所（番地）が登録できないとき' do
      it '空だと登録できない' do
        @buy_info.addr_house_number = nil
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("番地を入力してください")
      end
    end
    # address(building)はなし
    # tel_number
    context '電話番号が登録できない時' do
      it '空だと登録できない' do
        @buy_info.tel_number = nil
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("電話番号を入力してください")
      end
      it '12桁以上だと登録できない' do
        @buy_info.tel_number = Faker::Number.number(digits: 12)
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end
      it '数字以外が入っていると登録できない' do
        @buy_info.tel_number = Faker::Alphanumeric.alphanumeric(number: 11, min_alpha: 1)
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("電話番号に半角数字のみで記入してください")
      end
    end
    # user_id
    context 'userの影響で登録できないとき' do
      it 'user_idがないと登録できない' do
        @buy_info.user = nil
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("Userを入力してください")
      end
    end
    # good_id
    context 'goodの影響で登録できないとき' do
      it 'good_idないと登録できない' do
        @buy_info.good = nil
        @buy_info.valid?
        expect(@buy_info.errors.full_messages).to include("Goodを入力してください")
      end
    end
  end
end

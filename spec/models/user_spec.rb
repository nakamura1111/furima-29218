require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザ登録の可否' do
    context 'nicknameが登録できないとき' do
      it '空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
    end
    context 'emailが登録できないとき' do
      it '空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it '「@」がないと登録できない' do
        @user.email = 'sample_sample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスの入力を確認してください")
      end
      it '一意性制約に反すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end
    end
    context 'passwordが登録できないとき' do
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下だと登録できない' do
        @user.password = Faker::Alphanumeric.alphanumeric(number: 5, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'passwordが半角アルファベットのみだと登録できない' do
        @user.password = Faker::Alphanumeric.alpha(number: 6)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードの入力を確認してください")
      end
      it 'passwordが半角数字のみだと登録できない' do
        @user.password = Faker::Number.number(digits: 6)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードの入力を確認してください")
      end
      it 'password_confirmationが空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認）とパスワードの入力が一致しません")
      end
      it 'password_confirmationがpasswordと一致していないと登録できない' do
        @user.password = "#{@user.password}hoge"
        @user.password_confirmation = "#{@user.password}fuga"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認）とパスワードの入力が一致しません")
      end
    end
    context '名前が登録できないとき' do
      # 名前
      it 'given_nameが空だと登録できない' do
        @user.given_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(全角)を入力してください")
      end
      it 'given_nameに半角数字が混ざると登録できない' do
        @user.given_name = "#{@user.given_name}0"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(全角)の入力を確認してください")
      end
      it 'given_nameに半角アルファベットが混ざると登録できない' do
        @user.given_name = "#{@user.given_name}a"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(全角)の入力を確認してください")
      end
      it 'given_nameに半角記号文字が混ざると登録できない' do
        @user.given_name = "#{@user.given_name}@"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(全角)の入力を確認してください")
      end
      # 苗字
      it 'family_nameが空だと登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(全角)を入力してください")
      end
      it 'family_nameに半角数字が混ざると登録できない' do
        @user.family_name = "#{@user.family_name}0"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(全角)の入力を確認してください")
      end
      it 'family_nameに半角アルファベットが混ざると登録できない' do
        @user.family_name = "#{@user.family_name}a"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(全角)の入力を確認してください")
      end
      it 'family_nameに半角記号文字が混ざると登録できない' do
        @user.family_name = "#{@user.family_name}@"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(全角)の入力を確認してください")
      end
    end
    context '名前(カナ)が登録できないとき' do
      # 名前(カナ)
      it 'given_name_kanaが空だと登録できない' do
        @user.given_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)を入力してください")
      end
      it 'given_name_kanaに半角数字が混ざると登録できない' do
        @user.given_name_kana = "#{@user.given_name_kana}0"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)の入力を確認してください")
      end
      it 'given_name_kanaに半角アルファベットが混ざると登録できない' do
        @user.given_name_kana = "#{@user.given_name_kana}a"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)の入力を確認してください")
      end
      it 'given_name_kanaに半角記号文字が混ざると登録できない' do
        @user.given_name_kana = "#{@user.given_name_kana}@"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)の入力を確認してください")
      end
      it 'given_name_kanaにひらがなが混ざると登録できない' do
        @user.given_name_kana = "#{@user.given_name_kana}あ"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)の入力を確認してください")
      end
      it 'given_name_kanaに漢字が混ざると登録できない' do
        @user.given_name_kana = "#{@user.given_name_kana}漢"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)の入力を確認してください")
      end
      # 苗字(カナ)
      it 'family_name_kanaが空だと登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)を入力してください")
      end
      it 'family_name_kanaに半角数字が混ざると登録できない' do
        @user.family_name_kana = "#{@user.family_name_kana}0"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)の入力を確認してください")
      end
      it 'family_name_kanaに半角アルファベットが混ざると登録できない' do
        @user.family_name_kana = "#{@user.family_name_kana}a"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)の入力を確認してください")
      end
      it 'family_name_kanaに半角記号文字が混ざると登録できない' do
        @user.family_name_kana = "#{@user.family_name_kana}@"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)の入力を確認してください")
      end
      it 'family_name_kanaにひらがなが混ざると登録できない' do
        @user.family_name_kana = "#{@user.family_name_kana}あ"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)の入力を確認してください")
      end
      it 'family_name_kanaに漢字が混ざると登録できない' do
        @user.family_name_kana = "#{@user.family_name_kana}漢"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)の入力を確認してください")
      end
    end
    context '生年月日が登録できないとき' do
      it '空だと登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
    context '登録できるとき' do
      it '条件に合う入力を行っていれば登録できる' do
        expect(@user).to be_valid
        users = FactoryBot.create_list(:user, 30)
        users.each { |user| expect(user).to be_valid }
      end
    end
  end
end

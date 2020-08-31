require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザ登録の可否' do
    # nickname
    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    # email
    it 'emailが空だと登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailに「@」がないと登録できない' do
      @user.email = 'sample_sample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it '同じemailが既にDB上にあるとき登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    # password
    it 'passwordが空だと登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが6文字以下だと登録できない' do
      @user.password = 'a0a0a'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordが半角アルファベットのみだと登録できない' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end
    it 'passwordが半角数字のみだと登録できない' do
      @user.password = '000000'
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end
    it 'password_confirmationが空だと登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'password_confirmationがpasswordと一致していないと登録できない' do
      @user.password = "#{@user.password}hoge"
      @user.password_confirmation = "#{@user.password}fuga"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    # given_name
    it 'given_nameが空だと登録できない' do
      @user.given_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Given name can't be blank")
    end
    it 'given_nameに半角数字が混ざると登録できない' do
      @user.given_name = "#{@user.given_name}0"
      @user.valid?
      expect(@user.errors.full_messages).to include('Given name is invalid')
    end
    it 'given_nameに半角アルファベットが混ざると登録できない' do
      @user.given_name = "#{@user.given_name}a"
      @user.valid?
      expect(@user.errors.full_messages).to include('Given name is invalid')
    end
    it 'given_nameに半角記号文字が混ざると登録できない' do
      @user.given_name = "#{@user.given_name}@"
      @user.valid?
      expect(@user.errors.full_messages).to include('Given name is invalid')
    end
    # family_name
    it 'family_nameが空だと登録できない' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end
    it 'family_nameに半角数字が混ざると登録できない' do
      @user.family_name = "#{@user.family_name}0"
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name is invalid')
    end
    it 'family_nameに半角アルファベットが混ざると登録できない' do
      @user.family_name = "#{@user.family_name}a"
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name is invalid')
    end
    it 'family_nameに半角記号文字が混ざると登録できない' do
      @user.family_name = "#{@user.family_name}@"
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name is invalid')
    end
    # given_name_kana
    it 'given_name_kanaが空だと登録できない' do
      @user.given_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Given name kana can't be blank")
    end
    it 'given_name_kanaに半角数字が混ざると登録できない' do
      @user.given_name_kana = "#{@user.given_name_kana}0"
      @user.valid?
      expect(@user.errors.full_messages).to include('Given name kana is invalid')
    end
    it 'given_name_kanaに半角アルファベットが混ざると登録できない' do
      @user.given_name_kana = "#{@user.given_name_kana}a"
      @user.valid?
      expect(@user.errors.full_messages).to include('Given name kana is invalid')
    end
    it 'given_name_kanaに半角記号文字が混ざると登録できない' do
      @user.given_name_kana = "#{@user.given_name_kana}@"
      @user.valid?
      expect(@user.errors.full_messages).to include('Given name kana is invalid')
    end
    it 'given_name_kanaにひらがなが混ざると登録できない' do
      @user.given_name_kana = "#{@user.given_name_kana}あ"
      @user.valid?
      expect(@user.errors.full_messages).to include('Given name kana is invalid')
    end
    it 'given_name_kanaに漢字が混ざると登録できない' do
      @user.given_name_kana = "#{@user.given_name_kana}漢"
      @user.valid?
      expect(@user.errors.full_messages).to include('Given name kana is invalid')
    end
    # family_name_kana
    it 'family_name_kanaが空だと登録できない' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank")
    end
    it 'family_name_kanaに半角数字が混ざると登録できない' do
      @user.family_name_kana = "#{@user.family_name_kana}0"
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana is invalid')
    end
    it 'family_name_kanaに半角アルファベットが混ざると登録できない' do
      @user.family_name_kana = "#{@user.family_name_kana}a"
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana is invalid')
    end
    it 'family_name_kanaに半角記号文字が混ざると登録できない' do
      @user.family_name_kana = "#{@user.family_name_kana}@"
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana is invalid')
    end
    it 'family_name_kanaにひらがなが混ざると登録できない' do
      @user.family_name_kana = "#{@user.family_name_kana}あ"
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana is invalid')
    end
    it 'family_name_kanaに漢字が混ざると登録できない' do
      @user.family_name_kana = "#{@user.family_name_kana}漢"
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name kana is invalid')
    end
    # birth_day
    it 'birth_dayが空だと登録できない' do
      @user.birth_day = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end
    # 正常
    it '条件に合う入力を行っていれば登録できる' do
      expect(@user).to be_valid
    end
  end
end

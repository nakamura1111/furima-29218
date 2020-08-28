require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    
  end
  describe 'ユーザ登録の可否' do
    # nickname
    it 'nicknameが空だと登録できない' do
      
    end
    # email
    it 'emailが空だと登録できない' do
      
    end
    it 'emailに「@」がないと登録できない' do
      
    end
    it '同じemailが既にDB上にあるとき登録できない' do
      
    end
    # password
    it 'passwordが空だと登録できない' do
      
    end
    it 'passwordが6文字以下だと登録できない' do
      
    end
    it 'password_confirmationが空だと登録できない' do
      
    end
    it 'password_confirmationがpasswordと一致していないと登録できない' do
      
    end
    # given_name
    it "given_nameが空だと登録できない" do
      
    end
    it "given_nameに数字が混ざると登録できない" do
      
    end
    it "given_nameにアルファベットが混ざると登録できない" do
      
    end
    it "given_nameに記号文字が混ざると登録できない" do
      
    end
    # family_name
    it "family_nameが空だと登録できない" do
      
    end
    it "family_nameに数字が混ざると登録できない" do
      
    end
    it "family_nameにアルファベットが混ざると登録できない" do
      
    end
    it "family_nameに記号文字が混ざると登録できない" do
      
    end
    # given_name_kana
    it "given_name_kanaが空だと登録できない" do
      
    end
    it "given_name_kanaに数字が混ざると登録できない" do
      
    end
    it "given_name_kanaにアルファベットが混ざると登録できない" do
      
    end
    it "given_name_kanaに記号文字が混ざると登録できない" do
      
    end
    it 'given_name_kanaにひらがなが混ざると登録できない' do
      
    end
    it 'given_name_kanaに漢字が混ざると登録できない' do
      
    end
    # family_name_kana
    it "family_name_kanaが空だと登録できない" do
      
    end
    it "family_name_kanaに数字が混ざると登録できない" do
      
    end
    it "family_name_kanaにアルファベットが混ざると登録できない" do
      
    end
    it "family_name_kanaに記号文字が混ざると登録できない" do
      
    end
    it 'family_name_kanaにひらがなが混ざると登録できない' do
      
    end
    it 'family_name_kanaに漢字が混ざると登録できない' do
      
    end
    # birth_day
    it "birth_dayが空だと登録できない" do
      
    end
    # 正常
    it "条件に合う入力を行っていれば登録できる" do
      
    end
  end
end

require 'rails_helper'

RSpec.describe "商品出品機能", type: :system do
  before do
    
  end
  context "商品が出品できるとき" do
    it "指定通りに入力フォームを記入した場合出品できる" do

    end
  end
  context "商品が出品できないとき" do
    it "指定通りに入力フォームを記入しなかった場合出品できない" do
      
    end
    it "ログインしていないユーザは出品ページへ遷移できない" do
      
    end
  end
  it "価格を入力するとそれに応じた利益と手数料が表示される" do
    
  end
end

RSpec.describe "商品一覧表示機能", type: :system do
  before do
    
  end
  context "商品一覧を見られるとき" do
    it "ログアウト状態でも商品一覧ページに遷移できる" do
      
    end
  end
  context "商品一覧画面で表示されるもの" do
    it "画像・価格・商品名が表示されている" do

    end
    it "売却済み商品の場合「sold out」が表示されている" do
      
    end
  end
  context "商品一覧画面で表示されないもの" do
    it "売却済み商品でない場合「sold out」が表示されない" do

    end
  end
end

RSpec.describe "商品詳細表示機能", type: :system do
  before do
    
  end
  context "商品詳細を見られるとき" do
    it "ログアウト状態でも商品詳細ページに遷移できる" do
      
    end
  end
  context "商品詳細画面で表示されるもの" do
    it "商品の登録情報が表示されている" do

    end
    it "売却済み商品は「sold out」が表示されている" do
      
    end
    it "出品者は、商品の編集・削除のリンクが踏める" do
      
    end
    it "出品者でないユーザは、商品購入のリンクが踏める" do
      
    end
    it "未ログイン者は、商品購入のリンクが踏める" do
      
    end
  end
  context "商品詳細画面で表示されないもの" do
    it "未売却の商品は「sold out」が表示されていない" do
      
    end
    it "出品者は、商品購入のリンクが踏めない" do
      
    end
    it "出品者でないユーザは、商品の編集・削除のリンクが踏めない" do
      
    end
    it "未ログイン者は、商品の編集・削除のリンクが踏めない" do
      
    end
  end
end

RSpec.describe "商品削除機能", type: :system do
  before do
    
  end
  context "商品削除ができるとき" do
    it "出品者は、削除ができる" do
      
    end
  end
  context "商品削除ができないとき" do
    it "出品者でないユーザは削除できない" do
      
    end
    it "未ログイン者は削除できない" do
      
    end
    it "既に売れた商品は削除できない" do
      
    end
  end  
end

RSpec.describe "商品編集機能", type: :system do
  before do
    
  end
  context "商品編集ができるとき" do
    it "出品者は商品編集ページに遷移できる" do
      
    end
    it "全ての情報を変更した場合、変更できる" do
      
    end
    it "画像情報を入力しない場合、画像情報はそのままで他の要素は変更できる" do
      
    end
    it "何も変更しなかった場合、元の情報のまま更新される" do
      
    end
  end
  context "商品編集ができないとき" do
    it "出品者でないユーザは編集できない" do
      
    end
    it "未ログインユーザは編集できない" do
      
    end
    it "既に売れた商品は編集できない" do
      
    end
  end
end

require 'rails_helper'

RSpec.describe "商品出品機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @good = FactoryBot.build(:good)
    @good.user = @user
  end
  context "商品が出品できるとき" do
    it "ログイン状態で指定通りに入力フォームを記入した場合出品できる" do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: "purchase-btn-icon").click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 出品情報の入力
      attach_file( "good[image]", Rails.root.join("spec/fixtures/hero.jpg") )
      fill_in_new_good(@good)
      # 登録ボタンを押すと、出品情報がDBに登録されることを確認
      expect{
        find('input[name="commit"]').click
      }.to change{ Good.count }.by(1)
      # トップページに遷移していることを確認
      expect(current_path).to eq(root_path)
    end
  end
  context "商品が出品できないとき" do
    it "指定通りに入力フォームを記入しなかった場合出品できない" do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: "purchase-btn-icon").click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 出品情報の入力をしない
      # 登録ボタンを押すと、出品情報がDBに登録されることを確認
      expect{
        find('input[name="commit"]').click
      }.to change{ Good.count }.by(0)
      # 出品画面に遷移していることを確認
      expect(current_path).to eq(goods_path)
    end
    it "ログインしていないユーザは出品ページへ遷移できない" do
      # トップページに遷移する
      visit root_path
      # 出品ボタンをクリック
      find(class: "purchase-btn-icon").click
      # ログインページへ遷移していることを確認
      expect(current_path).to eq(new_user_session_path)
    end
  end
  context "利益と手数料が表示されるとき（非同期通信）" do
    it "価格を入力するとそれに応じた利益と手数料が表示される" do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: "purchase-btn-icon").click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 価格入力フォームのイベントが発火できるようになるための準備まで待つ
      sleep(3)
      # 商品価格の入力
      fill_in 'item-price', with: @good.price
      # 利益と手数料が表示されていることを確認
      expect(page).to have_selector("#add-tax-price", text: (@good.price*0.1).to_i)     # id指定による表示の確認
      expect(page).to have_selector("#profit", text: (@good.price*0.9).to_i)
    end
  end
end

RSpec.describe "商品一覧表示機能", type: :system do
  before do
    create_good
  end
  context "商品一覧画面を見られるとき" do
    it "ログアウト状態でも商品一覧ページに遷移できる" do
      # トップページに遷移
      visit root_path
      # 商品一覧ページへ遷移していることを確認
      expect(current_path).to eq(root_path)
    end
  end
  context "商品一覧画面で表示されるもの" do
    it "画像・価格・商品名が表示されている" do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 画像・価格・商品名が表示されているか確認
      expect(page).to have_selector("img[src$='hero.jpg']")                   # 画像の名前を含んでいるか確認している　セレクタ「.item-img」 ファイル名「#{@image.original_filename}」
      expect(page).to have_selector("div.item-price", text: "#{@good.price}円\n(税込み)\n0")
      expect(page).to have_selector("h3.item-name", text: @good.name)
    end
    it "売却済み商品の場合「sold out」が表示されている" do
      # 購入済み商品の作成
      create_buy
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 「sold out」が表示されているか確認
      expect(page).to have_selector(".sold-out")
    end
  end
  context "商品一覧画面で表示されないもの" do
    it "売却済み商品でない場合「sold out」が表示されない" do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 「sold out」が表示されているか確認
      expect(page).to have_no_selector(".sold-out")
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

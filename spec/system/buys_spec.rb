require 'rails_helper'

RSpec.describe '商品購入機能', type: :system do
  before do
    @good = create_good
  end
  context '購入ページに遷移できるとき' do
    it '出品者以外のログインユーザが購入ページに遷移し、フォームに正しく入力すると購入登録ができる' do
      # 購入者・購入品の記録
      @user = create_user
      # 購入者情報の作成
      @buyer = FactoryBot.build(:buyer)
      @buyer.buy_history.good = @good
      @buyer.buy_history.user = @user
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@buyer.buy_history.user)
      # 商品詳細ページへ遷移する
      visit good_path(@good)
      # 商品購入ページに遷移する
      find_link('購入画面に進む', href: good_buys_path(@good)).click
      # 商品購入ページに遷移しているか確認
      expect(current_path).to eq(good_buys_path(@good))
      # 更新情報の設定
      fill_in_new_buy(@buyer)
      # 二つのモデルのレコード数を確認
      expect(BuyHistory.count).to eq(0)
      expect(Buyer.count).to eq(0)
      # 送信ボタンクリック
      find('input[name="commit"]').click
      # 処理完了まで待った上で、レコード数を確認
      sleep(3)
      expect(BuyHistory.count).to eq(1)
      expect(Buyer.count).to eq(1)
      # トップページに遷移することを確認
      expect(current_path).to eq(root_path)
      # 「sold out」が表示されているか確認
      expect(page).to have_selector('.sold-out')
      # 支払い情報が残っていることを確認（今回は入金額で確認）
      require 'payjp'
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      payjp_charge_record = Payjp::Charge.all(limit: 1)['data'][0]['amount']
      expect(payjp_charge_record).to eq(@good.price)
    end
  end
  context '購入ページに遷移できないとき' do
    it '未ログインユーザは、購入ページへ遷移できない（ログインページに遷移する）' do
      # 商品詳細ページへ遷移する
      visit good_path(@good)
      # 商品購入ページに遷移する
      find_link('購入画面に進む', href: good_buys_path(@good)).click
      # ログインページに遷移しているか確認
      expect(current_path).to eq(new_user_session_path)
    end
    it '出品者は、購入ページに遷移できない（トップページに遷移する）' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品詳細ページへ遷移する
      visit good_path(@good)
      # 商品購入ページへのリンクがないことを確認
      expect(page).to have_no_link('購入画面に進む', href: good_buys_path(@good))
      # 商品購入ページに直接遷移しようとする
      visit good_buys_path(@good)
      # トップページに遷移しているか確認
      expect(current_path).to eq(root_path)
    end
    it '購入済み商品の購入ページに遷移できない（トップページに遷移する）' do
      # 訪問者として@good.userを用いる
      # 購入者情報の記録
      @buyer = create_buy
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品詳細ページへ遷移する
      visit good_path(@buyer.buy_history.good)
      # 商品購入ページへのリンクがないことを確認
      expect(page).to have_no_link('購入画面に進む', href: good_buys_path(@good))
      # 商品購入ページに直接遷移しようとする
      visit good_buys_path(@buyer.buy_history.good)
      # トップページに遷移しているか確認
      expect(current_path).to eq(root_path)
    end
  end
end

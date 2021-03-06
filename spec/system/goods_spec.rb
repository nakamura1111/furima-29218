require 'rails_helper'

RSpec.describe '商品出品機能', type: :system do
  before do
    @user = create_user
    @good = FactoryBot.build(:good)
    @good.user = @user
  end
  context '商品が出品できるとき' do
    it 'ログイン状態で指定通りに入力フォームを記入した場合出品できる' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: 'purchase-btn-icon').click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 出品情報の入力
      attach_file('good[images][]', Rails.root.join('spec/fixtures/hero.jpg'))
      fill_in_new_good(@good)
      # 登録ボタンを押すと、出品情報がDBに登録されることを確認
      expect do
        find('input[name="commit"]').click
      end.to change { Good.count }.by(1)
      # トップページに遷移していることを確認
      expect(current_path).to eq(root_path)
    end
    it 'ログイン状態・入力の不備がない場合、画像が複数枚でも出品できる' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: 'purchase-btn-icon').click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 出品情報の入力
      3.times do |i|
        attach_file('good[images][]', Rails.root.join("spec/fixtures/#{i}.jpg"), id: "item-image-#{i}")
      end
      fill_in_new_good(@good)
      # 登録ボタンを押すと、出品情報がDBに登録されることを確認
      expect do
        find('input[name="commit"]').click
      end.to change { Good.count }.by(1)
      # トップページに遷移していることを確認
      expect(current_path).to eq(root_path)
    end
  end
  context '商品が出品できないとき' do
    it '指定通りに入力フォームを記入しなかった場合出品できない' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: 'purchase-btn-icon').click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 出品情報の入力をしない
      # 登録ボタンを押すと、出品情報がDBに登録されることを確認
      expect do
        find('input[name="commit"]').click
      end.to change { Good.count }.by(0)
      # 出品画面に遷移していることを確認
      expect(current_path).to eq(goods_path)
    end
    it 'ログインしていないユーザは出品ページへ遷移できない' do
      # トップページに遷移する
      visit root_path
      # 出品ボタンをクリック
      find(class: 'purchase-btn-icon').click
      # ログインページへ遷移していることを確認
      expect(current_path).to eq(new_user_session_path)
    end
  end
  context '利益と手数料が表示されるとき' do
    it '価格を入力するとそれに応じた利益と手数料が表示される' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: 'purchase-btn-icon').click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 価格入力フォームのイベントが発火できるようになるための準備まで待つ
      sleep(1)
      # 商品価格の入力
      fill_in 'item-price', with: @good.price
      # 利益と手数料が表示されていることを確認
      expect(page).to have_selector('#add-tax-price', text: (@good.price * 0.1).to_i) # id指定による表示の確認
      expect(page).to have_selector('#profit', text: (@good.price * 0.9).to_i)
    end
  end
  context '画像プレビューが表示されるとき' do
    it '画像をフォームに入力すると、画像が表示される' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: 'purchase-btn-icon').click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 出品情報の入力
      attach_file('good[images][]', Rails.root.join('spec/fixtures/hero.jpg'))
      # JSの動作完了待ち
      sleep(1)
      # プレビュー画像が表示されていることを確認
      expect(find('#image-preview-new')[:'data-filename']).to include('hero.jpg')
    end
    it '複数枚画像を入力すると、いずれの画像も表示される' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: 'purchase-btn-icon').click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 出品情報の入力
      3.times do |i|
        attach_file('good[images][]', Rails.root.join("spec/fixtures/#{i}.jpg"), id: "item-image-#{i}")
      end
      # JSの動作完了待ち
      sleep(1)
      # プレビュー画像が表示されていることを確認
      3.times do |i|
        expect(all('#image-preview-new')[i][:'data-filename']).to include("#{i}.jpg")
      end
    end
    it '既に入力された画像の代わりに別の画像を入れると画像が入れ替わる' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: 'purchase-btn-icon').click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 出品情報の入力
      3.times do |i|
        attach_file('good[images][]',
                    Rails.root.join("spec/fixtures/#{i}.jpg"), id: "item-image-#{i}")
      end
      attach_file('good[images][]', Rails.root.join('spec/fixtures/hero.jpg'), id: 'item-image-1')
      # JSの動作完了待ち
      sleep(1)
      # プレビュー画像が表示されていることを確認
      expect(all('#image-preview-new')[0][:'data-filename']).to include('0.jpg')
      expect(all('#image-preview-new')[1][:'data-filename']).to include('hero.jpg')
      expect(all('#image-preview-new')[2][:'data-filename']).to include('2.jpg')
    end
  end
  context '画像が削除されるとき' do
    it 'フォーム入力が失敗した際に画像が入力されていた場合、画像の入力はなくなっている' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 出品ボタンをクリック
      find(class: 'purchase-btn-icon').click
      # 出品情報入力ページへ遷移していることを確認
      expect(current_path).to eq(new_good_path)
      # 出品情報の入力
      3.times do |i|
        attach_file('good[images][]', Rails.root.join("spec/fixtures/#{i}.jpg"), id: "item-image-#{i}")
      end
      # 登録ボタンを押す
      find('input[name="commit"]').click
      # 出品画面に遷移していることを確認
      expect(current_path).to eq(goods_path)
      # プレビュー画像が表示されていないことを確認
      expect(all('#image-preview')).to match([])
    end
  end
end

RSpec.describe '商品一覧表示機能', type: :system do
  before do
    @good = create_good
  end
  context '商品一覧画面を見られるとき' do
    it 'ログアウト状態でも商品一覧ページに遷移できる' do
      # トップページに遷移
      visit root_path
      # 商品一覧ページへ遷移していることを確認
      expect(current_path).to eq(root_path)
    end
  end
  context '商品一覧画面で表示されるもの' do
    it '画像・価格・商品名が表示されている' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 画像・価格・商品名が表示されているか確認
      expect(all('.item-img')[0][:src]).to include(@good.images.blobs[0].filename.to_s)
      expect(page).to have_selector('div.item-price', text: "#{@good.price}円\n(税込み)\n0")
      expect(page).to have_selector('h3.item-name', text: @good.name)
    end
    it '売却済み商品の場合「sold out」が表示されている' do
      # 購入済み商品の作成
      create_buy
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 「sold out」が表示されているか確認
      expect(page).to have_selector('.sold-out')
    end
  end
  context '商品一覧画面で表示されないもの' do
    it '売却済み商品でない場合「sold out」が表示されない' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 「sold out」が表示されていないことを確認
      expect(page).to have_no_selector('.sold-out')
    end
  end
end

RSpec.describe '商品詳細表示機能', type: :system do
  before do
    @good = create_good
  end
  context '商品詳細機能へ遷移できるとき' do
    it 'ログアウト状態でも商品詳細ページに遷移できる' do
      # トップページに遷移
      visit root_path
      # 商品情報をクリック
      find('div.item-price', text: "#{@good.price}円\n(税込み)\n0").click
      # 商品詳細ページへ遷移することを確認
      expect(current_path).to eq(good_path(@good))
    end
    it '詳細表示ページから前後の商品へ遷移できる' do
      # 遷移用商品の生成
      @good.delete
      n_good = 3
      @goods = FactoryBot.create_list(:good, n_good)
      # 商品詳細ページへ遷移
      visit good_path(@goods[0])
      n_good.times do |i|
        # 次の商品の詳細ページへのリンクをクリック
        find_link('後ろの商品').click
        # 次の商品に遷移できていることを確認
        next_good_int = (i + 1) % n_good
        expect(current_path).to eq(good_path(@goods[next_good_int]))
      end
      n_good.times do |i|
        # 前の商品の詳細ページへのリンクをクリック
        find_link('前の商品').click
        # 前の商品に遷移できていることを確認
        prev_good_int = (n_good - i - 1) % n_good
        expect(current_path).to eq(good_path(@goods[prev_good_int]))
      end
    end
  end
  context '商品詳細画面で表示されるもの' do
    it '商品の登録情報が表示されている' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品情報をクリック
      find('div.item-price', text: "#{@good.price}円\n(税込み)\n0").click
      # 商品詳細ページへ遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 商品情報が表示されていることを確認
      @good.images.blobs.each_with_index do |image, i|
        expect(all('.item-box-img')[i][:src]).to include(image.filename.to_s)
      end
      show_good(@good)
    end
    it '売却済み商品は「sold out」が表示されている' do
      # 購入済み商品の作成
      @buyer = create_buy
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品情報をクリック
      find('div.item-price', text: "#{@buyer.buy_history.good.price}円\n(税込み)\n0").click
      # 商品詳細ページへ遷移することを確認
      expect(current_path).to eq(good_path(@buyer.buy_history.good))
      # 「sold out」が表示されているか確認
      expect(page).to have_selector('.sold-out')
    end
    it '出品者は、商品の編集・削除のリンクが踏める' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品情報をクリック
      find('div.item-price', text: "#{@good.price}円\n(税込み)\n0").click
      # 商品詳細ページへ遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 出品商品の編集・削除のリンクがあるか確認
      expect(page).to have_link('商品の編集', href: edit_good_path(@good))
      expect(page).to have_link('削除', href: good_path(@good))
    end
    it '出品者でないユーザは、商品購入のリンクが踏める' do
      # 出品者でないユーザの作成
      @login_user = create_user
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@login_user)
      # 商品情報をクリック
      find('div.item-price', text: "#{@good.price}円\n(税込み)\n0").click
      # 商品詳細ページへ遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 出品商品の編集・削除のリンクがあるか確認
      expect(page).to have_link('購入画面に進む', href: good_buys_path(@good))
    end
    it '未ログイン者は、商品購入のリンクが踏める' do
      # トップページに遷移
      visit root_path
      # 商品情報をクリック
      find('div.item-price', text: "#{@good.price}円\n(税込み)\n0").click
      # 商品詳細ページへ遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 出品商品の編集・削除のリンクがあるか確認
      expect(page).to have_link('購入画面に進む', href: good_buys_path(@good))
    end
  end
  context '商品詳細画面で表示されないもの' do
    it '未売却の商品は「sold out」が表示されていない' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品情報をクリック
      find('div.item-price', text: "#{@good.price}円\n(税込み)\n0").click
      # 商品詳細ページへ遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 「sold out」が表示されていないことを確認
      expect(page).to have_no_selector('.sold-out')
    end
    it '出品者は、商品購入のリンクが踏めない' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品情報をクリック
      find('div.item-price', text: "#{@good.price}円\n(税込み)\n0").click
      # 商品詳細ページへ遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 出品商品の購入のリンクがないことを確認
      expect(page).to have_no_link('購入画面に進む', href: good_buys_path(@good))
    end
    it '出品者でないユーザは、商品の編集・削除のリンクが踏めない' do
      # 出品者でないユーザの作成
      @login_user = create_user
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@login_user)
      # 商品情報をクリック
      find('div.item-price', text: "#{@good.price}円\n(税込み)\n0").click
      # 商品詳細ページへ遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 出品商品の編集・削除のリンクがないことを確認
      expect(page).to have_no_link('商品の編集', href: edit_good_path(@good))
      expect(page).to have_no_link('削除', href: good_path(@good))
    end
    it '未ログイン者は、商品の編集・削除のリンクが踏めない' do
      # トップページに遷移
      visit root_path
      # 商品情報をクリック
      find('div.item-price', text: "#{@good.price}円\n(税込み)\n0").click
      # 商品詳細ページへ遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 出品商品の編集・削除のリンクがないことを確認
      expect(page).to have_no_link('商品の編集', href: edit_good_path(@good))
      expect(page).to have_no_link('削除', href: good_path(@good))
    end
  end
end

RSpec.describe '商品削除機能', type: :system do
  before do
    @good = create_good
  end
  context '商品削除ができるとき' do
    it '出品者は、削除ができる' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品詳細ページへ遷移する
      visit good_path(@good)
      # 出品商品の購入のリンクがあることを確認
      expect(page).to have_link('削除', href: good_path(@good))
      # 商品を削除するとレコードの数が1減ることを確認
      expect do
        find_link('削除', href: good_path(@good)).click
      end.to change { Good.count }.by(-1)
    end
  end
  context '商品削除ができないとき' do
    it '出品者でないユーザは削除できない' do
      # 出品者でないユーザの作成
      @login_user = create_user
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@login_user)
      # 商品詳細ページへ遷移する
      visit good_path(@good)
      # 出品商品の削除のリンクがないことを確認
      expect(page).to have_no_link('削除', href: good_path(@good))
    end
    it '未ログイン者は削除できない' do
      # 商品詳細ページへ遷移する
      visit good_path(@good)
      # 出品商品の削除のリンクがないことを確認
      expect(page).to have_no_link('削除', href: good_path(@good))
    end
    it '既に売れた商品は削除できない' do
      # 購入済み商品の作成
      @buyer = create_buy
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@buyer.buy_history.good.user)
      # 商品詳細ページへ遷移する
      visit good_path(@buyer.buy_history.good)
      # 出品商品の削除のリンクがないことを確認
      expect(page).to have_no_link('削除', href: good_path(@buyer.buy_history.good))
    end
  end
end

RSpec.describe '商品編集機能', type: :system do
  before do
    @good = create_good
  end
  context '商品編集ができるとき' do
    it '出品者は商品編集ページに遷移できる' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品詳細ページへ遷移する
      visit good_path(@good)
      # 商品編集ページに遷移
      find_link('商品の編集', href: edit_good_path(@good)).click
      # 商品編集ページに遷移しているか確認
      expect(current_path).to eq(edit_good_path(@good))
    end
    it '全ての情報を変更した場合、変更できる' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品編集ページへ遷移する
      visit edit_good_path(@good)
      # 更新情報の設定
      @good_input_for_edit = FactoryBot.build(:good)
      @good_input_for_edit.user = @good.user
      # 更新情報の設定(３枚の画像登録)
      3.times do |i|
        attach_file(
          'good[images][]',
          Rails.root.join("spec/fixtures/#{@good_input_for_edit.images.blobs[i].filename}"),
          id: "item-image-#{i}"
        )
      end
      fill_in_new_good(@good_input_for_edit)
      # 編集してもGoodモデルのカウントは変わらない
      expect do
        find('input[name="commit"]').click
      end.to change { Good.count }.by(0)
      # 商品詳細表示に遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 詳細表示には先ほど変更した内容が存在する
      @good_input_for_edit.images.blobs.each_with_index do |image, i|
        expect(all('.item-box-img')[i][:src]).to include(image.filename.to_s)
      end
      show_good(@good_input_for_edit)
    end
    it '画像情報を入力しない場合、画像情報はそのままで他の要素は変更できる' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品編集ページへ遷移する
      visit edit_good_path(@good)
      # 更新情報の設定
      @good_input_for_edit = FactoryBot.build(:good)
      @good_input_for_edit.user = @good.user
      # 更新情報の設定
      fill_in_new_good(@good_input_for_edit)
      # 編集してもGoodモデルのカウントは変わらない
      expect do
        find('input[name="commit"]').click
      end.to change { Good.count }.by(0)
      # 商品詳細表示に遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 詳細表示には先ほど変更した内容が存在する
      @good.images.blobs.each_with_index do |image, i|
        expect(all('.item-box-img')[i][:src]).to include(image.filename.to_s)
      end
      show_good(@good_input_for_edit)
    end
    it '何も変更しなかった場合、元の情報のまま更新される' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品編集ページへ遷移する
      visit edit_good_path(@good)
      # 編集してもGoodモデルのカウントは変わらない
      expect do
        find('input[name="commit"]').click
      end.to change { Good.count }.by(0)
      # 商品詳細表示に遷移することを確認
      expect(current_path).to eq(good_path(@good))
      # 更新された情報はない
      @good.images.blobs.each_with_index do |image, i|
        expect(all('.item-box-img')[i][:src]).to include(image.filename.to_s)
      end
      show_good(@good)
    end
  end
  context '商品編集ができないとき' do
    it '出品者でないユーザは編集できない' do
      # 出品者でないユーザの作成
      @login_user = create_user
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@login_user)
      # 商品詳細ページへ遷移する
      visit good_path(@good)
      # 出品商品の編集のリンクがないことを確認
      expect(page).to have_no_link('商品の編集', href: edit_good_path(@good))
      # 編集ページへ直接遷移してみる
      visit edit_good_path(@good)
      # トップページへ遷移することを確認
      expect(current_path).to eq(root_path)
    end
    it '未ログインユーザは編集できない' do
      # 商品詳細ページへ遷移する
      visit good_path(@good)
      # 出品商品の編集のリンクがないことを確認
      expect(page).to have_no_link('商品の編集', href: edit_good_path(@good))
      # 編集ページへ直接遷移してみる
      visit edit_good_path(@good)
      # サインインページへ遷移することを確認
      expect(current_path).to eq(new_user_session_path)
    end
    it '既に売れた商品は編集できない' do
      # 購入済み商品の作成
      @buyer = create_buy
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@buyer.buy_history.good.user)
      # 商品詳細ページへ遷移する
      visit good_path(@buyer.buy_history.good)
      # 出品商品の編集のリンクがないことを確認
      expect(page).to have_no_link('商品の編集', href: edit_good_path(@buyer.buy_history.good))
      # 編集ページへ直接遷移してみる
      visit edit_good_path(@buyer.buy_history.good)
      # トップページへ遷移することを確認
      expect(current_path).to eq(root_path)
    end
  end
  context '画像プレビューが表示されるとき' do
    it 'DBに登録済みの画像が表示される' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品詳細ページへ遷移する
      visit edit_good_path(@good)
      # 商品編集ページに遷移していることを確認
      expect(current_path).to eq(edit_good_path(@good))
      # プレビュー画像が表示されていることを確認
      3.times do |i|
        expect(all('#image-preview-old')[i][:src]).to include(@good.images.blobs[i].filename.to_s)
      end
    end
    it '複数枚画像を入力すると、いずれの画像も表示される' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 商品詳細ページへ遷移する
      visit edit_good_path(@good)
      # 商品編集ページに遷移していることを確認
      expect(current_path).to eq(edit_good_path(@good))
      # 出品画像の追加
      jpg_num = []
      3.times do |i|
        jpg_num[i] = (0..5).to_a.sample
        attach_file('good[images][]', Rails.root.join("spec/fixtures/#{jpg_num[i]}.jpg"), id: "item-image-#{i}")
      end
      # JSの動作完了待ち
      sleep(1)
      # プレビュー画像が表示されていることを確認
      3.times do |i|
        expect(all('#image-preview-new')[i][:'data-filename']).to include("#{jpg_num[i]}.jpg")
      end
    end
  end
end

RSpec.describe '商品検索機能', type: :system do
  before do
    @good = create_good
  end
  context '検索機能へ遷移できるとき' do
    it 'ログインユーザは遷移できる' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 詳細検索ボタンをクリック
      find(class: 'search-list').click
      # 検索ページへ遷移していることを確認
      expect(current_path).to eq(search_goods_path)
    end
    it '未ログインユーザでも遷移できる' do
      # トップページを訪問
      visit root_path
      # 詳細検索ボタンをクリック
      find(class: 'search-list').click
      # 検索ページへ遷移していることを確認
      expect(current_path).to eq(search_goods_path)
    end
    it 'ヘッダーのカテゴリ検索から検索ページへ遷移できる' do
      # トップページを訪問
      visit root_path
      # ヘッダのカテゴリボタンをクリック
      find('.category-list').click
      sleep(1)
      # カテゴリを一つ選んでクリック
      category = Category.find(@good.category_id)
      find("#btn#{category.id}").click
      # 検索結果のページへ遷移していることを確認
      expect(current_path).to eq(search_result_goods_path)
      # 登録済みの商品が表示されている
      expect(page).to have_content(@good.price)
      expect(page).to have_content(@good.name)
      expect(find('img.item-img')[:src]).to include(@good.images.blobs[0].filename.to_s)
    end
    it '詳細表示機能のリンクから検索ページへ遷移できる' do
      # 商品詳細ページを訪問
      visit good_path(@good)
      # カテゴリボタンをクリック
      find('button.another-item').click
      # 検索結果のページへ遷移していることを確認
      expect(current_path).to eq(search_result_goods_path)
      # 登録済みの商品が表示されている
      expect(page).to have_content(@good.price)
      expect(page).to have_content(@good.name)
      expect(find('img.item-img')[:src]).to include(@good.images.blobs[0].filename.to_s)
    end
    it 'ヘッダのキーワード入力欄に入力すると、検索ページに遷移できる' do
      # トップページへ遷移する
      visit root_path
      # 検索欄へ入力する
      fill_in_keyword_search_good(@good, page)
      # 検索ボタンをクリック
      find('img.search-icon').click
      # 検索結果のページに遷移していることを確認
      expect(current_path).to eq(search_result_goods_path)
      # 商品名・価格・画像が表示されることを確認
      expect(page).to have_content(@good.price)
      expect(page).to have_content(@good.name)
      expect(find('img.item-img')[:src]).to include(@good.images.blobs[0].filename.to_s)
      # 「該当する商品はありません」と表示されていないことを確認
      expect(page).to have_no_content('該当する商品はありません')
    end
  end
  context '詳細検索ができるとき' do
    it '検索条件が一致すると、商品名・価格・画像が表示される' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 詳細ページへ遷移する
      visit search_goods_path
      # 入力フォームへ入力する
      element_detail_search = find('.detail-search')
      fill_in_detail_search_good(@good, element_detail_search)
      # 検索ボタンをクリック
      element_detail_search.find('input[name="commit"]').click
      # 検索結果のページに遷移していることを確認
      expect(current_path).to eq(search_result_goods_path)
      # 商品名・価格・画像が表示されることを確認
      expect(page).to have_content(@good.price)
      expect(page).to have_content(@good.name)
      expect(find('img.item-img')[:src]).to include(@good.images.blobs[0].filename.to_s)
      # 「該当する商品はありません」と表示されていないことを確認
      expect(page).to have_no_content('該当する商品はありません')
    end
    it '検索条件が一致していないと、「該当する商品はありません」と表示される' do
      # 入力フォームに入力するインスタンスを生成する
      @good_search_input = FactoryBot.build(:good)
      @good_search_input.category_id = Category.where(id: 2..).sample.id while @good.category_id == @good_search_input.category_id
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 詳細ページへ遷移する
      visit search_goods_path
      # 入力フォームへ入力する
      element_detail_search = find('.detail-search')
      fill_in_detail_search_good(@good_search_input, element_detail_search)
      # 検索ボタンをクリック
      element_detail_search.find('input[name="commit"]').click
      # 検索結果のページに遷移していることを確認
      expect(current_path).to eq(search_result_goods_path)
      # 「該当する商品はありません」と表示されることを確認
      expect(page).to have_content('該当する商品はありません')
    end
  end
  context 'キーワード検索ができるとき' do
    it '検索条件が一致すると、商品名・価格・画像が表示される' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 詳細ページへ遷移する
      visit search_goods_path
      # 入力フォームへ入力する
      element_keyword_search = find('.keyword-search')
      fill_in_keyword_search_good(@good, element_keyword_search)
      # 検索ボタンをクリック
      element_keyword_search.find('input[name="commit"]').click
      # 検索結果のページに遷移していることを確認
      expect(current_path).to eq(search_result_goods_path)
      # 商品名・価格・画像が表示されることを確認
      expect(page).to have_content(@good.price)
      expect(page).to have_content(@good.name)
      expect(find('img.item-img')[:src]).to include(@good.images.blobs[0].filename.to_s)
      # 「該当する商品はありません」と表示されていないことを確認
      expect(page).to have_no_content('該当する商品はありません')
    end
    it '検索条件が一致していないと、「該当する商品はありません」と表示される' do
      # 入力フォームに入力するインスタンスを生成する
      @good_search_input = FactoryBot.build(:good)
      @good_search_input.category_id = Category.where(id: 2..).sample.id while @good.category_id == @good_search_input.category_id
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 詳細ページへ遷移する
      visit search_goods_path
      # 入力フォームへ入力する
      element_keyword_search = find('.keyword-search')
      fill_in_keyword_search_good(@good_search_input, element_keyword_search)
      # 検索ボタンをクリック
      element_keyword_search.find('input[name="commit"]').click
      # 検索結果のページに遷移していることを確認
      expect(current_path).to eq(search_result_goods_path)
      # 「該当する商品はありません」と表示されることを確認
      expect(page).to have_content('該当する商品はありません')
    end
  end
  context 'カテゴリ検索ができるとき' do
    it '検索条件が一致すると、商品名・価格・画像が表示される' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 詳細ページへ遷移する
      visit search_goods_path
      # 入力フォームへ入力する
      element_category_search = find('.category-search')
      fill_in_category_search_good(@good, element_category_search)
      # 検索ボタンをクリック
      element_category_search.find('input[name="commit"]').click
      # 検索結果のページに遷移していることを確認
      expect(current_path).to eq(search_result_goods_path)
      # 商品名・価格・画像が表示されることを確認
      expect(page).to have_content(@good.price)
      expect(page).to have_content(@good.name)
      expect(find('img.item-img')[:src]).to include(@good.images.blobs[0].filename.to_s)
      # 「該当する商品はありません」と表示されていないことを確認
      expect(page).to have_no_content('該当する商品はありません')
    end
    it '検索条件が一致していないと、「該当する商品はありません」と表示される' do
      # 検索用入力フォーム
      @good_search_input = FactoryBot.build(:good)
      @good_search_input.category_id = Category.where(id: 2..).sample.id while @good.category_id == @good_search_input.category_id
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 詳細ページへ遷移する
      visit search_goods_path
      # 入力フォームへ入力する
      element_category_search = find('.category-search')
      fill_in_category_search_good(@good_search_input, element_category_search)
      # 検索ボタンをクリック
      element_category_search.find('input[name="commit"]').click
      # 検索結果のページに遷移していることを確認
      expect(current_path).to eq(search_result_goods_path)
      # 「該当する商品はありません」と表示されることを確認
      expect(page).to have_content('該当する商品はありません')
    end
  end
  context '検索ページ以外のページへ遷移できるとき' do
    it 'トップページへ遷移できる' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 詳細ページへ遷移する
      visit search_goods_path
      # トップページへのリンクがあることを確認する
      expect(page).to have_link('トップページへ戻る', href: root_path)
      # 検索結果のページへ遷移する
      visit search_result_goods_path
      # トップページへのリンクがあることを確認する
      expect(page).to have_link('トップページへ戻る', href: root_path)
    end
    it '検索結果の商品の詳細ページに遷移できる' do
      # ログインする（トップページに遷移していることを確認済み）
      login_user(@good.user)
      # 詳細ページへ遷移する
      visit search_goods_path
      # 入力フォームへ入力する
      element_detail_search = find('.detail-search')
      fill_in_detail_search_good(@good, element_detail_search)
      # 検索ボタンをクリック
      element_detail_search.find('input[name="commit"]').click
      # 検索結果のページに遷移していることを確認
      expect(current_path).to eq(search_result_goods_path)
      # 商品の画像をクリック
      find('img.item-img').click
      # 商品詳細ページへ遷移できていることを確認
      expect(current_path).to eq(good_path(@good))
      # 商品情報が表示されていることを確認
      @good.images.blobs.each_with_index do |image, i|
        expect(all('.item-box-img')[i][:src]).to include(image.filename.to_s)
      end
      show_good(@good)
    end
  end
end

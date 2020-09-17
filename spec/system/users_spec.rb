require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # 新規登録ボタンをクリックする
      click_on('新規登録')
      # 新規登録ページへ移動しているか確認
      expect(current_path).to eq(new_user_registration_path)
      # ユーザー情報を入力する
      fill_in_new_user(@user)
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移しているか確認
      expect(current_path).to eq root_path
      # ログアウトボタンが表示される
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # 新規登録ボタンをクリックする
      click_on('新規登録')
      # 新規登録ページへ移動しているか確認
      expect(current_path).to eq(new_user_registration_path)
      # ユーザー情報を入力しない
      # サインアップボタンを押してもユーザーモデルのカウントは上がらない
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されるか確認
      expect(current_path).to eq(user_registration_path) # 遷移先変わるらしい（deviseのソース確認してみよう）
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # ログインボタンをクリックする
      click_on('ログイン')
      # 新規登録ページへ移動しているか確認
      expect(current_path).to eq(new_user_session_path)
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移しているか確認
      expect(current_path).to eq root_path
      # ログアウトボタンが表示される
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインできないとき' do
    it '保存されているユーザの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # ログインボタンをクリックする
      click_on('ログイン')
      # 新規登録ページへ移動しているか確認
      expect(current_path).to eq(new_user_session_path)
      # ユーザー情報を入力する
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻される
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe 'ログアウト', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  it 'ログアウトができる' do
    # ログインする
    login_user(@user)
    # ログアウトボタンをクリックする
    click_on('ログアウト')
    # トップページへ遷移しているか確認
    expect(current_path).to eq root_path
    # ログアウトボタンが表示されない
    expect(page).to have_no_content('ログアウト')
    # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示される
    expect(page).to have_content('新規登録')
    expect(page).to have_content('ログイン')
  end
end

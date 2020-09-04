module UserSupport
  def fill_in_new_user(user)
    fill_in 'nickname', with: user.nickname
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    fill_in 'password-confirmation', with: user.password
    fill_in 'first-name', with: user.given_name
    fill_in 'last-name', with: user.family_name
    fill_in 'first-name-kana', with: user.given_name_kana
    fill_in 'last-name-kana', with: user.family_name_kana
    select user.birth_day.year, from: "user[birth_day(1i)]"
    select user.birth_day.month, from: "user[birth_day(2i)]"
    select user.birth_day.day, from: "user[birth_day(3i)]"
  end

  def login_user(user)
      visit new_user_session_path
      fill_in('email', with: user.email)
      fill_in('password', with: user.password)
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
  end
end
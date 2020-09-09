FactoryBot.define do
  factory :user do
    nickname              { Faker::Internet.username(specifier: 5..10) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    given_name            { Gimei.name.first.kanji }
    family_name           { Gimei.name.last.kanji }
    given_name_kana       { Gimei.name.first.katakana }
    family_name_kana      { Gimei.name.last.katakana }
    birth_day             { Faker::Date.between(from: '1930-01-01', to: '2015-12-31') }
  end
end

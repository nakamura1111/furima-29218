FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { '0a0a0a' }
    password_confirmation { password }
    given_name            { Gimei.name.first.kanji }
    family_name           { Gimei.name.last.kanji }
    given_name_kana       { Gimei.name.first.katakana }
    family_name_kana      { Gimei.name.last.katakana }
    birth_day             { Faker::Date.between(from: '1930-01-01', to: '2015-12-31') }
  end
end

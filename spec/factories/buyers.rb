FactoryBot.define do
  factory :buyer do
    postal_code                 { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    addr_prefecture_id          { Prefecture.where(id: 2..).sample.id }
    addr_municipality           { "#{Gimei.address.city.kanji} #{Gimei.address.town.kanji}" }
    addr_house_number           { Faker::Address.street_address }
    addr_building               { Faker::Lorem.sentence(word_count: 1) }
    tel_number                  { Faker::Number.number(digits: 11) }
    association :buy_history
  end
end
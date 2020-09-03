FactoryBot.define do
  factory :buy_info do
    postal_code                 { FactoryBot.build(:buyer).postal_code }
    addr_prefecture_id          { FactoryBot.build(:buyer).addr_prefecture_id }
    addr_municipality           { FactoryBot.build(:buyer).addr_municipality }
    addr_house_number           { FactoryBot.build(:buyer).addr_house_number }
    addr_building               { FactoryBot.build(:buyer).addr_building }
    tel_number                  { FactoryBot.build(:buyer).tel_number }
    association :user
    association :good
  end
end

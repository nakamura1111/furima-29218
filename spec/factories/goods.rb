FactoryBot.define do
  factory :good do
    name                 { Faker::Lorem.paragraph_by_chars(number: 40) }
    description          { Faker::Lorem.paragraph_by_chars(number: 1000) }
    category_id          { Category.where(id: 2..).sample.id }
    status_id            { GoodStatus.where(id: 2..).sample.id }
    price                { Faker::Number.between(from: 300, to: 9_999_999) }
    origin_prefecture_id { Prefecture.where(id: 2..).sample.id }
    delivery_days_id     { DeliveryDay.where(id: 2..).sample.id }
    fee_charger_id       { FeeCharger.where(id: 2..).sample.id }
    association :user
    images               {[
                              Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/#{(0..5).to_a.sample}.jpg"), 'image/jpg'),
                              Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/#{(0..5).to_a.sample}.jpg"), 'image/jpg'),
                              Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/#{(0..5).to_a.sample}.jpg"), 'image/jpg'),
                         ]}
  end
end

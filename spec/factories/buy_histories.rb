FactoryBot.define do
  factory :buy_history do
    association :user
    association :good
  end
end

class BuyHistory < ApplicationRecord
  # バリデーション

  # アソシエーション
  belongs_to :user
  belogns_to :good
  has_one :address, presence: true
end

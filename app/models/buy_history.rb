class BuyHistory < ApplicationRecord
  # バリデーション(なし)

  # アソシエーション
  belongs_to :user
  belongs_to :good
  has_one :buyer, dependent: :destroy
end

class Buyer < ApplicationRecord
  # バリデーション
  validates :postal_code, presence: true, format: {with: /\A\d{3}[-]\d{4}\z/ }
  validates :addr_prefecture_id, presence: true, numericality: { other_than: 1 }
  validates :addr_municipality, presence: true
  validates :addr_house_number, presence: true
  validates :tel_number, presence: true

  # アソシエーション
  belongs_to :buy_history

  # ActiveHashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end

class Good < ApplicationRecord
  # バリデーション
  validates :name,                 presence: true
  validates :description,          presence: true
  validates :category_id,          presence: true, numericality: { other_than: 1 }
  validates :status_id,            presence: true, numericality: { other_than: 1 }
  validates :price,                presence: true, numericality: {greater_than_or_equal_to: 300, less_than: 10000000}
  validates :delivery_fee,         presence: true
  validates :origin_prefecture_id, presence: true, numericality: { other_than: 1 }
  validates :delivery_days_id,     presence: true, numericality: { other_than: 1 }
  validates :fee_charger_id,       presence: true, numericality: { other_than: 1 }

  # アソシエーション
  belongs_to :user

  # ActiveHashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :good_status
  belongs_to_active_hash :fee_charger
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_day
  
end

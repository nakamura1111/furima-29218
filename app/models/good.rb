class Good < ApplicationRecord
  # バリデーション
  validates :name,                 presence: true, length: { maximum: 40 }
  validates :description,          presence: true, length: { maximum: 1000 }
  validates :category_id,          presence: true, numericality: { other_than: 1 }
  validates :status_id,            presence: true, numericality: { other_than: 1 }
  validates :price,                presence: true, numericality: { greater_than_or_equal_to: 300, less_than: 10000000 }
  validates :origin_prefecture_id, presence: true, numericality: { other_than: 1 }
  validates :delivery_days_id,     presence: true, numericality: { other_than: 1 }
  validates :fee_charger_id,       presence: true, numericality: { other_than: 1 }
  validates :image,                presence: true

  # アソシエーション
  belongs_to :user
  has_one_attached :image

  # ActiveHashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :good_status
  belongs_to_active_hash :fee_charger
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_day
  
end

class Good < ApplicationRecord
  validates :name,                 presence: true
  validates :description,          presence: true
  validates :status_id,            presence: true
  validates :price,                presence: true, numericarity: {greater_than_or_equal_to: 300, less_than: 10000000}
  validates :delivery_fee,         presence: true
  validates :origin_prefecture_id, presence: true
  validates :delivery_days_id,     presence: true
  validates :fee_charger_id,       presence: true

  belongs_to :user, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  validates :category_id,          presence: true, numericality: { other_than: 1 }
end

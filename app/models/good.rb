class Good < ApplicationRecord
  # バリデーション
  with_options presence: true do
    validates :name,                 length: { maximum: 40, allow_blank: true }
    validates :description,          length: { maximum: 1000, allow_blank: true }
    validates :price,                numericality: {
                                      only_integer: true, greater_than_or_equal_to: 300, less_than: 10_000_000, allow_blank: true
                                     }
    validates :images
    with_options numericality: { other_than: 1, allow_blank: true } do
      validates :category_id
      validates :status_id
      validates :origin_prefecture_id
      validates :delivery_days_id
      validates :fee_charger_id
    end
  end
  # アソシエーション
  belongs_to :user
  has_one :buy_history, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  # ActiveHashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :good_status
  belongs_to_active_hash :fee_charger
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_day
end

class Buyer < ApplicationRecord
  # バリデーション(BuyInfoモデル(Formオブジェクト)に移動)

  # アソシエーション
  belongs_to :buy_history

  # ActiveHashのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end

class BuyInfo
  # DB保存はしないモデルの生成
  include ActiveModel::Model
  # カラム
  attr_accessor :postal_code, :addr_prefecture_id, :addr_municipality,
                :addr_house_number, :addr_building, :tel_number,
                :user, :good

  # バリデーション（BuyerとBuyHistoryモデル）
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :addr_prefecture_id, numericality: { other_than: 1 }
    validates :addr_municipality
    validates :addr_house_number
    validates :tel_number, length: { maximum: 11 }, numericality: true
    validates :user
    validates :good
  end

  # 保存時に使用するメソッドの設定（ActiveRecordのオーバーロード）
  def save
    buy_history = BuyHistory.create(user_id: user.id, good_id: good.id)
    Buyer.create(
      postal_code: postal_code, addr_prefecture_id: addr_prefecture_id, addr_municipality: addr_municipality,
      addr_house_number: addr_house_number, addr_building: addr_building, tel_number: tel_number,
      buy_history_id: buy_history.id
    )
  end
end

class BuyInfo
  # DB保存はしないモデルの生成
  include ActiveModel::Model
  # カラム
  attr_accessor :user_id, :good_id, :buy_history_id,
                :postal_code,:addr_prefecture_id, :addr_municipality,
                :addr_house_number, :addr_building, :tel_number

  # バリデーション（BuyerとBuyHistoryモデルとクレジットカード情報）
  with_options presence: true do
    validates :postal_code, format: {with: /\A\d{3}[-]\d{4}\z/ }
    validates :addr_prefecture_id, numericality: { other_than: 1 }
    validates :addr_municipality
    validates :addr_house_number
    validates :tel_number, length: {maximum: 11}, numericality: true 
  end
  
  # 保存時に使用するメソッドの設定（ActiveRecordのオーバーロード）
  def save
    buy_history = BuyHistory.create(user_id: user_id, good_id: good_id)
    Buyer.create(
      postal_code: postal_code, addr_prefecture_id: addr_prefecture_id, addr_municipality: addr_municipality,
      addr_house_number: addr_house_number, addr_building: addr_building, tel_number: tel_number,
      buy_history_id: buy_history.id
    )
  end
end
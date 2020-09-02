class BuyInfo
  # DB保存はしないモデルの生成
  include ActiveModel::Model
  # カラム
  attr_accessor :user_id, :good_id, :buy_history_id,
                :postal_code,:addr_prefecture_id, :addr_municipality,
                :addr_house_number, :addr_building, :tel_number,
                :token, :price

  # バリデーション（BuyerとBuyHistoryモデルとクレジットカード情報）
  validates :postal_code, presence: true, format: {with: /\A\d{3}[-]\d{4}\z/ }
  validates :addr_prefecture_id, presence: true, numericality: { other_than: 1 }
  validates :addr_municipality, presence: true
  validates :addr_house_number, presence: true
  validates :tel_number, presence: true
  validates :token, presence: true
  validates :price, presence: true, 
                    numericality: {
                      only_integer: true, greater_than_or_equal_to: 300, less_than: 10_000_000
                    }
  
  # 保存時に使用するメソッドの設定（ActiveRecordのオーバーロード）
  def save
    buy_history = BuyHistory.create(user_id: user_id, good_id: good_id)
    Buyer.create(
      postal_code: postal_code, addr_prefecture_id: addr_prefecture_id, addr_municipality: addr_municipality,
      addr_house_number: addr_house_number, addr_building: addr_building, tel_number: tel_number,
      buy_history_id: buy_history.id
    )
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(amount: price, card: token, currency: 'jpy')
  end
end
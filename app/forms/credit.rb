class Credit
  # DB保存はしないモデルの生成
  include ActiveModel::Model
  # カラム
  attr_accessor :token, :price

  # バリデーション（クレジットカード情報）
  with_options presence: true do
    validates :token
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10_000_000 }
  end

  # 保存時に使用するメソッドの設定（ActiveRecordのオーバーロード）
  def save
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(amount: price, card: token, currency: 'jpy')
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

n_users = 10
n_goods = 100
n_buyers = 50

n_users.times do |i|
  birth_day_year = (1930..(Time.now.year - 5)).to_a.sample
  birth_day_month = (1..12).to_a.sample
  birth_day_day = (1..28).to_a.sample
  User.create(
    nickname: "human#{i+1}", email: "human#{i+1}@sample.com", password: "human#{i+1}",
    given_name: "あああ", family_name: "あああ", 
    given_name_kana: "アアア", family_name_kana: "アアア", 
    birth_day: Date.new(birth_day_year, birth_day_month, birth_day_day)
  )
end
puts "ユーザ情報入力完了"

n_goods.times do |i|
  price = (300..9_999_999).to_a.sample
  good = Good.new(
    name: "sample#{i+1}", description: "sample#{i+1}_商品説明だよ", price: price,
    images: [Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/#{(0..5).to_a.sample}.jpg"), 'image/jpg')],
    category_id: Category.where(id: 2..).sample.id,
    status_id: GoodStatus.where(id: 2..).sample.id,
    origin_prefecture_id: Prefecture.where(id: 2..).sample.id,
    delivery_days_id: DeliveryDay.where(id: 2..).sample.id,
    fee_charger_id: FeeCharger.where(id: 2..).sample.id,
    user: User.all.sample
  )
  if good.valid?
    good.save
  else
    puts "#{i+1}: good.errors.full_messages"
  end
end
puts "商品情報入力完了"

n_buyers.times do |i|
  user = User.all.sample
  good = Good.where.not(user: user).sample
  # 購入履歴のDBレコード作成
  buy_history = BuyHistory.new( user: user, good: good )
  if !(buy_history.valid?)
    puts "#{i+1}: 既に購入済みの商品を選択していた or #{buy_history.errors.full_messages}"
    next
  end
  # 購入のDBレコード作成
  buyer = Buyer.new(
    postal_code:        "000-0000",
    addr_prefecture_id: Prefecture.where(id: 2..).sample.id,
    addr_municipality:  "市町村区サンプル",
    addr_house_number:  "番地サンプル",
    addr_building:      "建物の名前と部屋番号のサンプル",
    tel_number:         "09012345678",
    buy_history:        buy_history
  )
  if buyer.valid?
    buy_history.save
    buyer.save
  else
    puts "#{i+1}: #{buyer.errors.full_messages}"
  end
end
puts "購入情報入力完了"

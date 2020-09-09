module BuySupport
  def fill_in_new_buy(buyer)
    fill_in 'card-number', with: 4_242_424_242_424_242
    fill_in 'card-exp-month', with: Date.today.month
    fill_in 'card-exp-year', with: ( Date.today.year + 1 ) % 100      # カード有効期限を一年後に設定
    fill_in 'card-cvc', with: 123
    fill_in 'postal-code', with: buyer.postal_code
    select Prefecture.find(buyer.addr_prefecture_id).name, from: "addr_prefecture_id"
    fill_in 'city', with: buyer.addr_municipality
    fill_in 'addresses', with: buyer.addr_house_number
    fill_in 'building', with: buyer.addr_building
    fill_in 'phone-number', with: buyer.tel_number
  end

  def create_buy
    return FactoryBot.create(:buyer)
    # @buy_info = FactoryBot.create(:buy_info)
    # @buy_info = FactoryBot.build(:buy_info)
    # # buy_infoレコードの作成
    # @buy_info = BuyInfo.new(
    #   postal_code: @buy_info.postal_code, addr_prefecture_id: @buy_info.addr_prefecture_id, addr_municipality: @buy_info.addr_municipality,
    #   addr_house_number: @buy_info.addr_house_number, addr_building: @buy_info.addr_building, tel_number: @buy_info.tel_number,
    #   user: @buy_info.user, good: good
    # )
    # # レコード記録
    # @buy_info.save
  end
end
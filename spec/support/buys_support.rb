module BuySupport
  # def fill_in_new_good(good)
  #   fill_in 'item-name', with: good.name
  #   fill_in 'item-info', with: good.description
  #   select Category.find(good.category_id).name, from: "good[category_id]"
  #   select GoodStatus.find(good.status_id).name, from: "good[status_id]"
  #   select FeeCharger.find(good.fee_charger_id).name, from: "good[fee_charger_id]"
  #   select Prefecture.find(good.origin_prefecture_id).name, from: "good[origin_prefecture_id]"
  #   select DeliveryDay.find(good.delivery_days_id).name, from: "good[delivery_days_id]"
  #   fill_in 'item-price', with: good.price
  # end
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
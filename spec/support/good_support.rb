module GoodSupport
  # imageのインプットは含まれない
  def fill_in_new_good(good)
    fill_in 'item-name', with: good.name
    fill_in 'item-info', with: good.description
    select Category.find(good.category_id).name, from: "good[category_id]"
    select GoodStatus.find(good.status_id).name, from: "good[status_id]"
    select FeeCharger.find(good.fee_charger_id).name, from: "good[fee_charger_id]"
    select Prefecture.find(good.origin_prefecture_id).name, from: "good[origin_prefecture_id]"
    select DeliveryDay.find(good.delivery_days_id).name, from: "good[delivery_days_id]"
    fill_in 'item-price', with: good.price
  end
  
  def create_good
    @good = FactoryBot.create(:good)
    # @good = FactoryBot.build(:good)
    # @image_path = Rails.root.join("spec/fixtures/hero.jpg")
    # @image = fixture_file_upload(@image_path)
    # Good.create(                                                                    # カラムと値のセットで地道にレコード作成
    #   name: @good.name, description: @good.description, category_id: @good.category_id,
    #   status_id: @good.status_id, price: @good.price, origin_prefecture_id: @good.origin_prefecture_id,
    #   delivery_days_id: @good.delivery_days_id, fee_charger_id: @good.fee_charger_id, user: @good.user,
    #   image: @image
    # )
  end
end
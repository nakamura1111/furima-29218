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
    return FactoryBot.create(:good)
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
  
  def show_good(good)
    # imageの確認は含まれない
    expect(find('h2.name').text).to include("#{good.name}")
    expect(find('.item-price').text).to include("#{good.price}")
    expect(all('.detail-value')[0].text).to eq(good.user.nickname)
    expect(all('.detail-value')[1].text).to eq(Category.find(good.category_id).name)
    expect(all('.detail-value')[2].text).to eq(GoodStatus.find(good.status_id).name)
    expect(all('.detail-value')[3].text).to eq(FeeCharger.find(good.fee_charger_id).name)
    expect(all('.detail-value')[4].text).to eq(Prefecture.find(good.origin_prefecture_id).name)
    expect(all('.detail-value')[5].text).to eq(DeliveryDay.find(good.delivery_days_id).name)
  end

  def fill_in_search_good(good)
    select Category.find(good.category_id).name, from: "q[category_id_eq]"
    select GoodStatus.find(good.status_id).name, from: "q[status_id_eq]"
    select DeliveryDay.find(good.delivery_days_id).name, from: "q[delivery_days_id_eq]"
    choose search_price_condition(good.price)
  end

  private

  def search_price_condition(price)
    if price < 1000
      return "q_price_lt_1_000"
    elsif price < 10000
      return "q_price_lt_10_000"
    elsif price < 100000
      return "q_price_lt_100_000"
    else 
      return "q_price_lt_10_000_000"
    end
  end
end
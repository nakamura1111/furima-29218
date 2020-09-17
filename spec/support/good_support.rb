module GoodSupport
  # imageのインプットは含まれない
  def fill_in_new_good(good)
    fill_in 'item-name', with: good.name
    fill_in 'item-info', with: good.description
    select Category.find(good.category_id).name, from: 'good[category_id]'
    select GoodStatus.find(good.status_id).name, from: 'good[status_id]'
    select FeeCharger.find(good.fee_charger_id).name, from: 'good[fee_charger_id]'
    select Prefecture.find(good.origin_prefecture_id).name, from: 'good[origin_prefecture_id]'
    select DeliveryDay.find(good.delivery_days_id).name, from: 'good[delivery_days_id]'
    fill_in 'item-price', with: good.price
  end

  def create_good
    FactoryBot.create(:good)
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

  # 詳細が表示されているか確認する(imageの確認は含まれない)
  # ABCsizeのBranchが52と高い -> メソッドを呼び出しすぎらしい
  def show_good(good)
    good_detail = all('.detail-value')
    expect(find('h2.name')).to have_content(good.name)
    expect(find('.item-price')).to have_content(good.price)
    expect(good_detail[0]).to have_content(good.user.nickname)
    expect(good_detail[1]).to have_content(Category.find(good.category_id).name)
    expect(good_detail[2]).to have_content(GoodStatus.find(good.status_id).name)
    expect(good_detail[3]).to have_content(FeeCharger.find(good.fee_charger_id).name)
    expect(good_detail[4]).to have_content(Prefecture.find(good.origin_prefecture_id).name)
    expect(good_detail[5]).to have_content(DeliveryDay.find(good.delivery_days_id).name)
  end

  # 詳細検索フォームへの入力
  def fill_in_detail_search_good(good, element)
    element.select Category.find(good.category_id).name, from: 'q[category_id_eq]'
    element.select GoodStatus.find(good.status_id).name, from: 'q[status_id_eq]'
    element.select DeliveryDay.find(good.delivery_days_id).name, from: 'q[delivery_days_id_eq]'
    element.choose search_price_condition(good.price)
  end

  # キーワード検索フォームへの入力
  def fill_in_keyword_search_good(good, element)
    element.fill_in 'q_name_cont', with: good.name.slice(10..20)
  end

  # カテゴリ検索フォームへの入力
  def fill_in_category_search_good(good, element)
    element.select Category.find(good.category_id).name, from: 'q[category_id_eq]'
  end

  private

  def search_price_condition(price)
    if price < 1000
      'q_price_lt_1_000'
    elsif price < 10_000
      'q_price_lt_10_000'
    elsif price < 100_000
      'q_price_lt_100_000'
    else
      'q_price_lt_10_000_000'
    end
  end
end

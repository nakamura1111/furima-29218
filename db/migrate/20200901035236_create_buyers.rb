class CreateBuyers < ActiveRecord::Migration[6.0]
  def change
    create_table :buyers do |t|
      t.string       :postal_code,   null: false
      t.integer      :addr_prefecture_id, null: false
      t.string       :addr_municipality, null: false
      t.string       :addr_house_number, null: false
      t.string       :addr_building,     null: false
      t.string       :tel_number,    null: false
      t.references   :buy_history,                 null: false, foreign_key: true
      t.timestamps
    end
  end
end

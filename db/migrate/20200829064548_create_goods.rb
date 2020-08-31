class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.string       :name,                 null: false
      t.text         :description,          null: false
      t.integer      :category_id,          null: false
      t.integer      :status_id,            null: false
      t.integer      :price,                null: false
      t.integer      :origin_prefecture_id, null: false
      t.integer      :delivery_days_id,     null: false
      t.integer      :fee_charger_id,       null: false
      t.references   :user,                 null: false, foreign_key: true

      t.timestamps
    end
  end
end

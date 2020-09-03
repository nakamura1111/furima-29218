class CreateBuyHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :buy_histories do |t|
      t.references :user, null: false, foreiger_key: true
      t.references :good, null: false, foreiger_key: true
      t.timestamps
    end
  end
end

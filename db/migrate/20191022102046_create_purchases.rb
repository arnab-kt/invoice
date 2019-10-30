class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.date :date, null: false

      t.timestamps
    end
  end
end

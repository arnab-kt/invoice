class CreatePurchaseItems < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_items do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :rate, null: false, precision: 8, scale: 2
      t.references :purchase, null: false, foreign_key: true

      t.timestamps
    end
  end
end

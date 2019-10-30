class CreateSaleItems < ActiveRecord::Migration[6.0]
  def change
    create_table :sale_items do |t|
      t.integer :quantity, null: false
      t.decimal :rate, null: false, precision: 8, scale: 2
      t.references :product, null: false, foreign_key: true
      t.references :sale, null: false, foreign_key: true

      t.timestamps
    end
  end
end

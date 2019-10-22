class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.boolean :active, null: false, default: false
      t.references :brand, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :uom, null: false, foreign_key: true

      t.timestamps
    end
  end
end

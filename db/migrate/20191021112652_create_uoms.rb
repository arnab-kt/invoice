class CreateUoms < ActiveRecord::Migration[6.0]
  def change
    create_table :uoms do |t|
      t.string :name, null: false
      t.string :abbreviation, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end

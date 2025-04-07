class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :stock_quantity
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end

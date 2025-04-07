class CreatePromotions < ActiveRecord::Migration[8.0]
  def change
    create_table :promotions do |t|
      t.string :title
      t.string :discount_type
      t.decimal :discount_value
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end

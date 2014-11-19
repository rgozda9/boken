class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :stock_quantity
      t.boolean :on_sale
      t.decimal :sale_price
      t.string :status
      t.string :image
      t.decimal :rating
      t.string :category
      t.string :genre

      t.timestamps
    end
  end
end

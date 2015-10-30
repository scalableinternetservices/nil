class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :price, precision: 5, scale: 2
      t.boolean :paid
      t.boolean :ready
      t.boolean :assigned
      t.boolean :arrived
      t.text :address
      t.string :zip
      t.string :phone
      t.datetime :shipped_at
      t.datetime :arrived_at
      t.datetime :confirmed_at
      t.references :restaurant, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

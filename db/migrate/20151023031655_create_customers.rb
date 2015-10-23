class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.text :address
      t.string :zip
      t.string :phone
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

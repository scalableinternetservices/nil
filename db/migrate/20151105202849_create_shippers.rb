class CreateShippers < ActiveRecord::Migration
  def change
    create_table :shippers do |t|
      t.string :name
      t.text :address
      t.string :zip
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

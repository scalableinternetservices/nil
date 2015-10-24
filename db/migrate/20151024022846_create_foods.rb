class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name, :null => false
      t.decimal :price, precision: 5, scale: 2
      t.integer :num_left, :default => 0
      t.integer :num_sold, :default => 0
      t.text :description
      t.string :image
      t.references :restaurant, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end

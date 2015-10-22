class CreateUserCustomers < ActiveRecord::Migration
  def change
    create_table :user_customers do |t|
      t.string :name
      t.text :address
      t.integer :zipcode
      t.integer :phone

      t.timestamps null: false
    end
  end
end

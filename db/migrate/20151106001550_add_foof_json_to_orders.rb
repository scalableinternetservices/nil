class AddFoofJsonToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :food_json, :text
  end
end

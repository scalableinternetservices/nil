class AddFoodToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :food, index: true, foreign_key: true
  end
end

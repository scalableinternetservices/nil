class RemoveFoodFromOrders < ActiveRecord::Migration
  def change
    remove_reference :orders, :food, index: true, foreign_key: true
  end
end

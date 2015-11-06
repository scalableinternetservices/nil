class AddShipperToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :shipper, index: true, foreign_key: true
  end
end

class RemoveCustomerFromOrder < ActiveRecord::Migration
  def change
    remove_reference :orders, :customer, index: true, foreign_key: true
  end
end

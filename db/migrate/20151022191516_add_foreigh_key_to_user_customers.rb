class AddForeighKeyToUserCustomers < ActiveRecord::Migration
  def change
		add_reference :user_customers, :user, index: true
		add_foreign_key :user_customers, :users
  end
end

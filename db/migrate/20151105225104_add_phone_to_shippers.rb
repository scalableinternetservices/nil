class AddPhoneToShippers < ActiveRecord::Migration
  def change
    add_column :shippers, :phone, :string
  end
end

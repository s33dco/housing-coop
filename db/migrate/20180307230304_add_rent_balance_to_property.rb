class AddRentBalanceToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :rent_balance, :decimal, default: 0.00
  end
end

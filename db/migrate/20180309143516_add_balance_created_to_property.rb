class AddBalanceCreatedToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :balance_created, :timestamp
  end
end

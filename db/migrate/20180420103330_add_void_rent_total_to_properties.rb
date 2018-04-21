class AddVoidRentTotalToProperties < ActiveRecord::Migration[5.1]
  def change
  	add_column :properties, :void_rent_total, :decimal, default: 0.0
  end
end

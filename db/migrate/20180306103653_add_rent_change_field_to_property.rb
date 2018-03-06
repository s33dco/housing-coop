class AddRentChangeFieldToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :rent_change, :date
  end
end

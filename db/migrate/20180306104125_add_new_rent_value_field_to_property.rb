class AddNewRentValueFieldToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :new_rent_value, :string
  end
end

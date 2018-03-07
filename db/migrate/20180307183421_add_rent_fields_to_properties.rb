class AddRentFieldsToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :new_rent_value, :decimal
    add_column :properties, :rent_change, :date
    add_column :properties, :rent_begin, :date
    add_column :properties, :rent_end, :date
  end
end

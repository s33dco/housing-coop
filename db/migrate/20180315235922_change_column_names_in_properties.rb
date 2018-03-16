class ChangeColumnNamesInProperties < ActiveRecord::Migration[5.1]
  def change
  	rename_column :properties, :house_name_no, :name_or_number
  	rename_column :properties, :rent_begin, :rent_period_start
  	rename_column :properties, :rent_end, :last_day_of_rent_period
  	rename_column :properties, :rent_change, :first_day_of_next_rent_period
  end
end

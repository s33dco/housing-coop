class ChangeCloumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :properties, :last_day_of_rent_period, :moving_out_date
  end
end

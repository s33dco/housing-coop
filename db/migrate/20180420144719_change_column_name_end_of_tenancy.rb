class ChangeColumnNameEndOfTenancy < ActiveRecord::Migration[5.1]
  def change
  	rename_column :properties, :end_of_tenancy, :end_of_tenancy_balance, default: 0.0

  end
end

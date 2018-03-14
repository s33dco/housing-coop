class AddEndOfTenancyToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :end_of_tenancy, :decimal
  end
end

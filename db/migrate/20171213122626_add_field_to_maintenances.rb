class AddFieldToMaintenances < ActiveRecord::Migration[5.0]
  def change
    add_reference :maintenances, :property, foreign_key: true
  end
end

class AddContractorToMaintenance < ActiveRecord::Migration[5.0]
  def change
    add_reference :maintenances, :contractor, foreign_key: true
  end
end

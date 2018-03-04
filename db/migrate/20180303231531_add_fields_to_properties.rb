class AddFieldsToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :kitchen_upgrade, :date
    add_column :properties, :coop_house, :boolean
  end
end

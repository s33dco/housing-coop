class AddFieldToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :maintenance, :boolean
  end
end

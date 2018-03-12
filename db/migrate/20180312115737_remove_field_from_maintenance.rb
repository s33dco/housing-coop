class RemoveFieldFromMaintenance < ActiveRecord::Migration[5.1]

	def up
	  remove_column :maintenances, :worktype, :string
	end

	def down
	  add_column :maintenances, :worktype, :string
	end

end

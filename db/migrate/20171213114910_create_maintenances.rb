class CreateMaintenances < ActiveRecord::Migration[5.0]
  def change
    create_table :maintenances do |t|
      t.string :worktype
      t.decimal :cost
      t.text :details
      t.date :date

      t.timestamps
    end
  end
end

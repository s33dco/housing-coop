class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :house_name_no
      t.string :address1
      t.string :address2
      t.string :postcode
      t.decimal :rent_per_week

      t.timestamps
    end
  end
end

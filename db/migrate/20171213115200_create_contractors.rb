class CreateContractors < ActiveRecord::Migration[5.0]
  def change
    create_table :contractors do |t|
      t.string :phone
      t.string :name
      t.text :details

      t.timestamps
    end
  end
end

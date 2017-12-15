class CreateRents < ActiveRecord::Migration[5.0]
  def change
    create_table :rents do |t|
      t.references :property, foreign_key: true
      t.decimal :payment
      t.date :date
      t.string :notes

      t.timestamps
    end
  end
end

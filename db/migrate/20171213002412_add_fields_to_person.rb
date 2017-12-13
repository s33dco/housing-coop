class AddFieldsToPerson < ActiveRecord::Migration[5.0]
  def change
    add_reference :people, :property, foreign_key: true
    add_column :people, :words, :text
  end
end

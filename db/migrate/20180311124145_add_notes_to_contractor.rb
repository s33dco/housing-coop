class AddNotesToContractor < ActiveRecord::Migration[5.1]
  def change
    add_column :contractors, :notes, :text
  end
end

class AddFieldsToContractor < ActiveRecord::Migration[5.0]
  def change
    add_column :contractors, :email, :string
  end
end

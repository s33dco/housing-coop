class AddSlugToContractors < ActiveRecord::Migration[5.1]
  def change
    add_column :contractors, :slug, :string
  end
end

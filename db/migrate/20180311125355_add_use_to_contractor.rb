class AddUseToContractor < ActiveRecord::Migration[5.1]
  def change
    add_column :contractors, :use, :boolean
  end
end

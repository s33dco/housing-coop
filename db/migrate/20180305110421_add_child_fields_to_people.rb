class AddChildFieldsToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :child, :boolean
  end
end

class AddSlugToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :slug, :string
  end
end

class AddEmailToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :email, :string
  end
end

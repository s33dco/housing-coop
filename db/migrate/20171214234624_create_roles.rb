class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.references :person, foreign_key: true
      t.references :job, foreign_key: true
      t.date :role_start
      t.date :role_end

      t.timestamps
    end
  end
end

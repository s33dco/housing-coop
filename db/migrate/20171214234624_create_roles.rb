class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.references :person, foreign_key: true
      t.references :job, foreign_key: true
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end

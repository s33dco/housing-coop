class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.decimal :participation
      t.date :joined
      t.date :exit
      t.boolean :member, default:true
      t.boolean :housed, default:true
      t.boolean :secretary, default:false
      t.boolean :rent_officer, default:false
      t.boolean :admin, default:false

      t.timestamps
    end
  end
end

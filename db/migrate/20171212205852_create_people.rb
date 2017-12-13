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
      t.boolean :member, default:false
      t.boolean :housed, default:true
      t.boolean :secretary, default:true
      t.boolean :rent_officer, default:true
      t.boolean :admin, default:true

      t.timestamps
    end
  end
end

class CreateWorktypes < ActiveRecord::Migration[5.1]
  def change
    create_table :worktypes do |t|
      t.string :title

      t.timestamps
    end
  end
end

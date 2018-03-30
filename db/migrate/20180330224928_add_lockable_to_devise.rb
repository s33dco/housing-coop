class AddLockableToDevise < ActiveRecord::Migration[5.1]
  def change
  	add_column :people, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
  	add_column :people, :unlock_token, :string # Only if unlock strategy is :email or :both
  	add_column :people, :locked_at, :datetime
  	add_index :people, :unlock_token, unique: true
  end
end

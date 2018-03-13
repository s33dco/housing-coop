class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :calendars, :when, :date_time
  end
end

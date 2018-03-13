class AddFieldToCalendars < ActiveRecord::Migration[5.1]
  def change
    add_column :calendars, :link, :string
  end
end

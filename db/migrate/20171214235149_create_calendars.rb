class CreateCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :calendars do |t|
      t.datetime :when
      t.string :where
      t.string :title
      t.text :details

      t.timestamps
    end
  end
end

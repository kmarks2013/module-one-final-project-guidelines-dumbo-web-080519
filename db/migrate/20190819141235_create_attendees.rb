class CreateAttendees < ActiveRecord::Migration[5.0]
  def change
    create_table :attendees do |t|
      t.string :name
      t.boolean :cosplay
      t.string :costume
      t.string :attendee_status
    end
  end
end

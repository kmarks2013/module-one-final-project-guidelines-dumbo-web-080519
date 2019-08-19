class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.integer :attendee_id
      t.integer :merchandise_id
      t.timestamps
    end
  end
end

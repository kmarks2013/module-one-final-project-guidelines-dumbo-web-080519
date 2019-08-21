class CreateBooths < ActiveRecord::Migration[5.0]
  def change
    create_table :booths do |t|
      t.string :name
      t.string :booth_type
      
    end
  end
end
#did not add location/ will come back to it later 
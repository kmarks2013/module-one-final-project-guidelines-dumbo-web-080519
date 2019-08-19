class CreateMerchandises < ActiveRecord::Migration[5.0]
  def change
    create_table :merchandises do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :inventory
      t.integer :booth_id
    end
  end
end

class AddColumnToPurchases < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :merchandise_price, :float
  
  end
end

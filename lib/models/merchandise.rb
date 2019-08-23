class Merchandise < ActiveRecord::Base
    
    has_many :purchases
    has_many :attendees, through: :purchases
    belongs_to :booth 

    def self.add_new_item(name, description, price, inventory, booth_id)
        Merchandise.create(name: name, description: description, price: price, inventory: inventory, booth_id: booth_id)
    end

    def change_price=(price)
        self.price = price
    end 

    def create_purchase(attendee_id)
        Purchase.create(attendee_id: attendee_id, merchandise_id: self.id)
        self.inventory -= 1
    end

    def refund(attendee_id)
        purchase = self.purchases.find_by(attendee_id: attendee_id)
        purchase.destroy
        self.inventory += 1
    end

end
#these methods were developed to help us build our methods in ohter models

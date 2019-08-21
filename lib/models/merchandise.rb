class Merchandise < ActiveRecord::Base
    
    has_many :purchases
    has_many :attendees, through: :purchases
    belongs_to :booth 

    def self.add_new_item(name, description, price, inventory, booth_id)
        Merchandise.create(name: name, description: description, price: price, inventory: inventory, booth_id: booth_id)
        #adds new inventory to the merchandise
    end


    # def update_inventory(num)
    #     #updates number of items in inventory column
    #     self.inventory = num 

    #     if self.create_purchase
    #         inventory -=1
    #     elsif self.add_
    # end
    
    def change_price=(price)
        #changes price of item
        self.price = price
    end 

    

    def create_purchase(attendee_id)
        #creates a new purchase with an attendee and subtracts one from the inventory
        Purchase.create(attendee_id: attendee_id, merchandise_id: self.id)
        self.inventory -= 1
       
    end

    def refund(attendee_id)
        purchase = self.purchases.find_by(attendee_id: attendee_id)
        purchase.destroy
        self.inventory += 1

    end



end
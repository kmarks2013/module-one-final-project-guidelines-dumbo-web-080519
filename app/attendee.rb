class Attendee < ActiveRecord::Base
    has_many :purchases
    has_many :merchandises, through: :purchases

    def specific_purchase(item_name)
        self.merchandises.find_by(name: item_name)
        #maybe return booth id from purchases
    end
    
    def total_spent
        (self.merchandieses.map {|merch| merch.price}).sum
    end
    
    def booths_visited
        #should return an array of which booth he visited
    end
end



# what would you like to do      possible attendee menus and submenus
#     see total purchases
#     return an item
#     find a booth
#     check teh inventory of other items
#         buy selected item
#         
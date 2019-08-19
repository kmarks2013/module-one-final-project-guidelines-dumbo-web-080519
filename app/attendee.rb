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
    
    #booths visited
end
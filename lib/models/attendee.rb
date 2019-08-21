class Attendee < ActiveRecord::Base
    validates :name , presence: true
    has_many :purchases
    has_many :merchandises, through: :purchases
    has_many :booths , through: :merchandises

    def self.returning_attendee
        puts "What is your name?"
        name = gets.chomp.capitalize
        if !Attendee.find_by(name: name)
            puts "Please try another name"
            name = gets.chomp
        else 
            Attendee.find_by(name: name)
        end
        # add a conditional to retrun something if a booth doesnt exist.
        # name = TTY::Prompt.new.ask("What is your booth name?"){ |q| q.validate name: }
    end

    def all_merchandise
        Merchandise.all
    end

    def select_merchandise(item_name)
        self.all_merchandise.find do |merchandise|
            merchandise.name == item_name
        end
    end

    def buy_item(item_name)
        merch = self.select_merchandise(item_name)
        Purchase.create(attendee_id: self.id, merchandise_id: merch.id)
        merch.inventory -= 1
    end

    def return_item(item_name)
        merch = self.specific_purchase(item_name)
        purchase = self.purchases.find_by(merchandise_id: merch.id)
        purchase.destroy
        merch.inventory += 1
    end


    def specific_purchase(item_name)
        self.merchandises.find_by(name: item_name)
        #maybe return booth id from purchases
    end
    
    def total_spent
        total_spent =(self.merchandieses.map {|merch| merch.price}).sum
        puts total_spent
    end
    
    def booths_visited #TTY promt this m**tha F8ka
        booth_names = self.booths.map do |booth|
            booth.name
        end.uniq
        puts booth_names
        #instead of uniq, if the person visited a booth mroe than once, raise a message
        #"WOW YOU REALLY LVOE THIS #{STAND_NAME}"
    end

    def see_purchases
         self.purchases.map do |purchase|
            purchase.merchandise
        end
    end

    def items_purchased
        items =see_purchases.map do |merchandise|
            merchandise.name
        end
        puts items
    end




end



# what would you like to do      possible attendee menus and submenus
#     see total purchases
#     return an item
#     find a booth
#     check teh inventory of other items
#         buy selected item
#         
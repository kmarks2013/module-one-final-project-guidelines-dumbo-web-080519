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
            name = gets.chomp.capitalize
        else 
            Attendee.find_by(name: name)
        end
        # add a conditional to retrun something if a booth doesnt exist.
        # name = TTY::Prompt.new.ask("What is your booth name?"){ |q| q.validate name: }
    end

    def all_merchandise
        Merchandise.all
    end

    def merchandise_names
       merch = self.all_merchandise.map {|merchandise| merchandise.name}
        puts merch
    end

    def select_merchandise(item_name)
        self.all_merchandise.find do |merchandise|
            merchandise.name == item_name
        end
    end
    
    
    def specific_purchase(item_name)
        Purchase.find_by(attendee_id: self.id, merchandise_id: self.select_merchandise(item_name).id)
        # self.merchandises.find_by(name: item_name)
        #maybe return booth id from purchases
    end
    
    def total_spent
        total_spent =(self.merchandises.map {|merch| merch.price}).sum
        puts total_spent
    end

    def visit_booths
        booths = Booth.all.map do |booth|
            {name: booth.name, booth_id: booth.id}
        end
        booth_selection = TTY::Prompt.new.select("Which booth would you like to visit?",booths)
        #BOOTH SELECTION NEEDS TO BE TRANSFERED TO A BOOTH OBJECT NOT A STRING!!!!!
        booth_selection.merchandises.map do |merchandise|

            {name: merchandise.name, merch_id: merchandise.id}
        end
        
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
        items = see_purchases.map do |merchandise|
            merchandise.name
        end
        puts items
    end
    
    def return_item
        items = self.see_purchases.map do |merchandise|
            {name: merchandise.name, merch_id: merchandise.id}
        end
        merch = TTY::Prompt.new.select("Here is a list of your purchases. What would you like to return?",items)
        purchase = self.specific_purchase(merch)
        purchase.destroy 
        puts "your item has been refunded!"
        restock = self.select_merchandise(merch)
        restock.update(inventory: restock.inventory + 1)
    end
    
    def buy_item
        items = self.all_merchandise.map do |merchandise| 
            {name: merchandise.name, merch_id: merchandise.id}
        end
        merch = TTY::Prompt.new.select("Here is a list of items you can buy", items)
        Purchase.create(attendee_id: self.id, merchandise_id: self.select_merchandise(merch).id)
        puts "Thank you for your purchase!"
        
        stock = self.select_merchandise(merch)
        stock.update(inventory: stock.inventory - 1)
     
    end

    # def return_item
    #     merch = TTY::Prompt.new.select("What would you like to return") do |menu|
    #         menu.choice "#{self.items_purchased}"
    #     end
    #         # merch = self.specific_purchase
    #         purchase = self.purchases.find_by(merchandise_id: merch.id)
    #         purchase.destroy
    #         merch.inventory += 1
    # end
    
    
end



# what would you like to do      possible attendee menus and submenus
#     see total purchases
#     return an item
#     find a booth
#     check teh inventory of other items
#         buy selected item
#         
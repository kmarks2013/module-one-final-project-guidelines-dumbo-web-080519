class Attendee < ActiveRecord::Base
    validates :name , presence: true
    has_many :purchases
    has_many :merchandises, through: :purchases
    has_many :booths , through: :merchandises

    def self.returning_attendee
        puts "What is your name?"
        name = gets.chomp.capitalize
        if !Attendee.find_by(name: name)
            puts "We could not find that name! Please try again!"
            name = gets.chomp.capitalize
            Attendee.find_by(name: name)
            # cli.welcomee
            # self.returning_attendee until Attendee.find_by(name: name) == !nil
        else 
            Attendee.find_by(name: name)
        end
        # add a conditional to retrun something if a booth doesnt exist.
        # name = TTY::Prompt.new.ask("What is your booth name?"){ |q| q.validate name: }
    end

    def all_merchandise
        Merchandise.all
    end

    # def all_booths
    #     Booth.all
    # end

    def select_booth(booth_name)
        Booth.all.find do |booth|
            booth.name == booth_name
        end
    end

    def booth_menu_hash
        Booth.all.map do |booth|
            {name: booth.name, booth_id: booth.id}
        end
    end
    
    def visit_booths
        booths = self.booth_menu_hash
        booth_choice = TTY::Prompt.new.select("Which booth would you like to visit?",booths)
        booth_selection = self.select_booth(booth_choice)
        #BRB
        
        merch = booth_selection.merch_menu_hash
        merch_choice = TTY::Prompt.new.select("What would like to purchase", merch)
        Purchase.create(attendee_id: self.id, merchandise_id: booth_selection.select_merch(merch_choice).id)
        
        puts "Thank you for buying #{merch_choice} from #{booth_choice}"
        stock = booth_selection.select_merch(merch_choice)
        stock.update(inventory: stock.inventory - 1)
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

    end
    
    def total_spent
        total_spent =(self.merchandises.map {|merch| merch.price}).sum
        puts total_spent
    end

    
    def booths_visited 
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
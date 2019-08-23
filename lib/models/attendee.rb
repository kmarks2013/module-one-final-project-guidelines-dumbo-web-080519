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
        else 
            Attendee.find_by(name: name)
        end
    end

    def all_merchandise
        Merchandise.all
    end

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
        
        merch = booth_selection.merch_menu_hash
        merch_choice = TTY::Prompt.new.select("What would like to purchase", merch)
        Purchase.create(attendee_id: self.id, merchandise_id: booth_selection.select_merch(merch_choice).id)
        
        puts ""
        puts "#{booth_choice} Receipt"
        puts ""
        puts "You have bought #{merch_choice}!"
        puts ""
        puts "Your total is today $#{booth_selection.select_merch(merch_choice).price}!"
        puts ""
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
    end

    def see_purchases
        self.purchases.map do |purchase|
            purchase.merchandise
        end
    end
    
    # def items_purchased
    #     items = see_purchases.map do |merchandise|
    #         merchandise.name
    #     end
    #     puts items
    # end
    # didn't implement into the menus yet but the method
    
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
    
end

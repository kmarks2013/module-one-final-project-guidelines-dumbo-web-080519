class Booth < ActiveRecord::Base
    
    has_many :merchandises 
    has_many :purchases, through: :merchandises
    has_many :attendees, through: :merchandises
    attr_accessor :prompt

    def self.selection
        puts "What is your booth name?"
        name = gets.chomp.capitalize
        if !Booth.find_by(name: name) 
            puts "Please try another name"
            name = gets.chomp.capitalize
            Booth.find_by(name: name)
        else
            Booth.find_by(name: name)
        end
        # Booth.find_by(name: name)
        
        # add a conditional to retrun something if a booth doesnt exist.
        # name = TTY::Prompt.new.ask("What is your booth name?"){ |q| q.validate name: }
    end
    
    def self.register_booth(name, booth_type)
        Booth.new(name: name, booth_type:booth_type)
    end

    def sell_merchandise(attendee_id, merchandise_id)
        Purchase.create(attendee_id: attendee_id, merchandise_id: merchandise_id)
    end


    def create_merchandise(name, description, price, inventory)
        Merchandise.new(name: name, description: description, inventory: inventory, booth_id: self)
    end

    def sale_inventory(name, merchandise_id)
        #updates inventory everytime a purchase is made or when merchandise is reduced from purchase
        Purchase.create(attendee_id: name, merchandise_id: merchandise_id)
    end
    
    def check_merchandise
        #returns an array/list of all the merchandise available
       merchandise =  self.merchandises.map {|merchandise| merchandise.name }
       puts merchandise 
       return merchandise
    end
    
    def select_merch(merch_name)
        self.merchandises.find do |merch|
            merch.name == merch_name
        end
    end
    # (item_name,num )
    def add_to_inventory
        item_name = TTY::Prompt.new.ask("What item would you like to restock?").capitalize
        num = TTY::Prompt.new.ask("How many are you adding to the inventory?")
        stock = self.select_merch(item_name)
        stock.update(inventory: stock.inventory + num.to_i)
    end

    def merch_menu_hash
        self.merchandises.map do |merchandise|
            {name: merchandise.name, merch_id: merchandise.id}
        end
    end
    
   

    def sales_made 
        sales = self.purchases.map { |purchase| purchase.merchandise.name }
        puts sales
    end

    def number_of_sales
        #helpter method for sales revenues
        total_sales = self.purchases.count
        puts total_sales
    end

    def sales_revenue
        revenue = self.purchases.reduce(0) {|sum,purchase| sum += purchase.merchandise.price}
        puts revenue
    end
    
    def list_of_attendees
        attendees = (self.attendees.map {|attendee| attendee.name}).uniq
        puts attendees
    end


    # def number_attendees
    #     #checks how the booth or bought from the booth. This would have to be unique 
    # end


    #WE WILL REVISIT AFTER IMPLEMENTING TTY PROMPT. 
    # def issue_refund(attendee_id, name) 
        
    #     purchase = self.purchases.find_by(attendee_id: attendee_id)
    #     if purchase.merchandise_id = self.merchandises.name.id
    #         purchase.destroy
    #         self.merchandises.name.inventory += 1
    #     end
    # end




end


# PRIORITY CLI
# possible booth menu/ submenus
# check inventory (list or chocie?)
# restock inventory
# numbers of sales
# revenue ........later on consider profit *(revenue - expenses) maybe lease expenses... etc 
# number of patrons unique sales

#list of attendees
#sale (subtracts from )



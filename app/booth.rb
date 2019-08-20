class Booth < ActiveRecord::Base
    has_many :merchandises 
    has_many :purchases, through: :merchandises
    has_many :attendees, through: :merchandises


    def sale_inventory(name, merchandise_id)
        #updates inventory everytime a purchase is made or when merchandise is reduced from purchase
        Purchase.create(attendee_id: name, merchandise_id: merchandise_id)
    end

    

    def add_to_inventory(item_name,num )
        #add new items to inventory
        self.check_merchandise.select do |merchandise|
            if merchandise.name == item_name 
                item_name.inventory += num 
            end
        end
    end

    def check_merchandise
        #returns an array/list of all the merchandise available
        self.merchandises
    end

    def sales_made 
        self.purchases 
    end
    def number_of_sales
        #helpter method for sales revenues
        
    end

    def sales_revenue
        #takes price* 
        self.number_of_sales
    end
    
    def number_attendees
        #checks how the booth or bought from the booth
    end

    def issue_refund 
        #delete a purchase 
        # update inventory/add to inventory += 1 to reflect the refund
    end



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



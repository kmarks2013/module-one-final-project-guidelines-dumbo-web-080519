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
        self.merchandises.map {|merchandise| merchandise.name }
    end

    def sales_made 
        self.purchases.map { |purchase| purchase.merchandise.name }
    end

    def number_of_sales
        #helpter method for sales revenues
        self.sales_made.count
    end



    def sales_revenue
        self.purchases.reduce(0) {|sum,purchase| sum += purchase.merchandise.price}
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



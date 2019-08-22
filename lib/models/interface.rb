class Interface

    attr_accessor :prompt, :user

    def initialize()
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Welcome to Comic Con!"
        prompt.select("Are you an attendee or a booth") do |menu|
            menu.choice "Attendee", -> {Attendee.returning_attendee}
            menu.choice "Booth", -> {Booth.selection}
        end

    end

    # welcome method should returning user or new user which leads to new attendee/newbooth or returning booth.new booth

    def booth_main_menu
        prompt.select("Welcome Booth Operator, what would you like to do today?" ) do |menu|
            menu.choice "View Merchandise", -> {self.user.check_merchandise}
            menu.choice "Update Inventory", -> {self.user.add_to_inventory}
            menu.choice "List of Customers", -> {self.user.list_of_attendees}
            menu.choice "Mumber of Sales", -> {self.user.number_of_sales}
            menu.choice "Items Sold", -> {self.user.sales_made}
            menu.choice "Sales Revenue", -> {self.user.sales_revenue}
        end
    end

    def attendee_main_menu
        prompt.select("HELLO attendee") do |menu|
            menu.choice "See all Merchandise Available", -> {self.user.merchandise_names}
            menu.choice "See Booths Visited", -> {self.user.booths_visited}
            menu.choice "Buy Item by name", -> {self.user.buy_item}
            menu.choice "Visit Booths", ->{self.user.visit_booths}
            menu.choice "Return Item", -> {self.user.return_item}
            menu.choice "Total Spent", -> {self.user.total_spent}
        end
    end

    
#somewhere in that method add purchases to attendee

#ISSUE WHEN UPDATING INVENTORY 
#couldn't add argument
    # Welcome Booth Operator, what would you like to do today? update inventory
    #     What item would you like to restock? Pokeball
    #     How many are you adding to the inventory? 100



end
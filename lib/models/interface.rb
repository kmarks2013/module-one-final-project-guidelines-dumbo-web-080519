class Interface

    attr_accessor :prompt, :user

    def initialize()
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Welcome to Comic Con!"
        prompt.select("Are you an attendee or a booth") do |menu|
            menu.choice "Attendee", -> {Attendee.selection}
            menu.choice "Booth", -> {Booth.selection}
        end

    end


    def booth_main_menu
        prompt.select("Welcome Booth Operator, what would you like to do today?" ) do |menu|
            menu.choice "view merchandise", -> {self.user.check_merchandise}
            menu.choice "update inventory", -> {self.user.add_to_inventory}
            menu.choice "list of customers", -> {self.user.list_of_attendees}
            menu.choice "number of sales", -> {self.user.number_of_sales}
            menu.choice "items sold", -> {self.user.sales_made}
            menu.choice "sales revenue", -> {self.user.sales_revenue}
        end
    end
#ISSUE WHEN UPDATING INVENTORY 
#couldn't add argument
    # Welcome Booth Operator, what would you like to do today? update inventory
    #     What item would you like to restock? Pokeball
    #     How many are you adding to the inventory? 100



end
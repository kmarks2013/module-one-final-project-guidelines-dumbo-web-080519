class Interface

    attr_accessor :prompt, :user

    def initialize()
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Welcome to Comic Con!"
        prompt.select("Are you an Attendee or a Booth Operator?") do |menu|
            menu.choice "Attendee", -> {Attendee.returning_attendee}
            menu.choice "Booth Operator", -> {Booth.selection}
        end

    end

    # welcome method should return a user or new user which leads to new attendee/new booth or returning booth/new booth

    def booth_main_menu
        prompt.select("Welcome Booth Operator, what would you like to do today?" ) do |menu|
            menu.choice "View Merchandise", -> {self.user.check_merchandise}
            menu.choice "Update Inventory", -> {self.user.add_to_inventory}
            menu.choice "List of Customers", -> {self.user.list_of_attendees}
            menu.choice "Number of Sales", -> {self.user.number_of_sales}
            menu.choice "Items Sold", -> {self.user.sales_made}
            menu.choice "Sales Revenue", -> {self.user.sales_revenue}
            menu.choice "Exit", -> {exit!}
        end
    end

    def attendee_main_menu
        prompt.select("Welcome attendee what would you like to do today?") do |menu|
            menu.choice "See all Merchandise Available", -> {self.user.merchandise_names}
            menu.choice "See Booths Visited", -> {self.user.booths_visited}
            menu.choice "Buy Item by name", -> {self.user.buy_item}
            menu.choice "Visit Booths", ->{self.user.visit_booths}
            menu.choice "Return Item", -> {self.user.return_item}
            menu.choice "Total Spent", -> {self.user.total_spent}
            menu.choice "Exit!", -> {exit!}
        end
    end


end
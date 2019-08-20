class Interface

    attr_accessor :prompt, :user

    def initialize()
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Welcome to Comic Con!"
        prompt.select("Are you an attendee or a booth") do |menu|
            menu.choice "Attendee"#, -> { Attendee.main_menu }
            menu.choice "Booth", -> {Booth.selection}
        end

    end


    def booth_main_menu
        prompt.select("Welcome Booth Operator, what would you like to do today?" ) do |menu|
            menu.choice "all merchandise", -> {self.check_merchandise}
        end
    end
    
    # def  booth_selection
    #     puts "What is your booth name?"
    #     name = gets.chomp
    #     Booth.find_by(name: name)
    #     # add a conditional to retrun something if a booth doesnt exist.
    # end

end
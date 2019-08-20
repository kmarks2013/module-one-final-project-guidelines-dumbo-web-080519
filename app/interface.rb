class Interface

    attr_accessor :prompt, :user

    def initialize()
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Welcome to Comic Con!"
        puts "Are you an Attendee or Booth " #booth as in booth owner

    end
end
require_relative '../config/environment'

cli = Interface.new 
user_object = cli.welcome

cli.user = user_object


system "clear"
if user_object.class == Attendee
    cli.attendee_main_menu
elsif user_object.class == Booth
    cli.booth_main_menu
end


# binding.pry
# puts "HELLO WORLD"

require_relative '../config/environment'

cli = Interface.new 
user_object = cli.welcome

cli.user = user_object

# choice = cli.booth_main_menu
choice = cli.attendee_main_menu

# if cli.user == "Attendee"
#     choice = cli.attendee_main_menu
# elsif cli.user == "Booth"
#     choice = cli.booth_main_menu
# end

# if Interface.
binding.pry
puts "HELLO WORLD"

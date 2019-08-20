require_relative '../config/environment'

cli = Interface.new 
user_object = cli.welcome

cli.user = user_object
choice = cli.booth_main_menu

binding.pry
puts "HELLO WORLD"

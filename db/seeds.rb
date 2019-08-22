Attendee.destroy_all
Purchase.destroy_all
Merchandise.destroy_all
Booth.destroy_all

kenny = Attendee.create(name: "Kenny", cosplay: true, costume: "Goku", attendee_status: "Non-press")
brian = Attendee.create(name: "Brian", cosplay: true, costume: "Pikachu", attendee_status: "Press")
joel = Attendee.create(name: "Joel", cosplay: false, attendee_status: "Press")
matt = Attendee.create(name: "Matt", cosplay: true, costume: "Hulk", attendee_status: "Non-Press")
shane = Attendee.create(name: "Shane", cosplay: true, costume:"Jon Snow, King of the North", attendee_status: "Non-press")

pokemon = Booth.create(name: "Pokemon", booth_type: "Toys" )
gameofthrones = Booth.create(name: "Gameofthrones", booth_type: "Collectibles")
dragonball = Booth.create(name: "Dragonball" , booth_type: "Dragonball Collectibles")

long_claw = Merchandise.create( name: "Long Claw", description: "Valeryan Steel Sword Replica", price: 50.99, inventory: 15, booth_id: gameofthrones.id)
dragon_ball = Merchandise.create( name: "Dragon Ball", description: "Golden orb with 4 stars glowing inside", price: 13.99, inventory: 90, booth_id: dragonball.id)
pokeball = Merchandise.create( name: "Pokeball", description: "Pokemon Storage Device", price: 9.99, inventory: 5, booth_id: pokemon.id)
pokedex = Merchandise.create(name:"Pokedex", description: "Pokemon Info", price: 100.00, inventory: 1000, booth_id: pokemon.id)
eevee_plushie = Merchandise.create(name: "Eevee Plushie", description: "Sofft cuddly doll", price: 7.50, inventory:8, booth_id: pokemon.id)
dragon_glass = Merchandise.create(name: "Dragon Glass", description: "Obsidian dagger", price: 150.99, inventory: 20, booth_id: gameofthrones.id)
needle = Merchandise.create(name: "Needle", description: "Thin bladed sword. Stick 'em with the pointy end'", price: 22.50, inventory:10, booth_id: gameofthrones.id)


p1 = Purchase.create(attendee_id: kenny.id , merchandise_id: dragon_ball.id)
p2 = Purchase.create(attendee_id: brian.id, merchandise_id: pokeball.id)
p3 = Purchase.create(attendee_id: shane.id, merchandise_id: long_claw.id)
p4 = Purchase.create(attendee_id: shane.id, merchandise_id: pokedex.id)
p7 = Purchase.create(attendee_id: brian.id, merchandise_id: pokedex.id)
p5 = Purchase.create(attendee_id: brian.id, merchandise_id: eevee_plushie.id)
p6 = Purchase.create(attendee_id: shane.id, merchandise_id: needle.id)


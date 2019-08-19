Attendee.destroy_all
Purchase.destroy_all
Merchandise.destroy_all

kenny = Attendee.create(name: "Kenny", cosplay: true, costume: "Goku", attendee_status: "Non-press")
brian = Attendee.create(name: "Brian", cosplay: true, costume: "Pikachu", attendee_status: "Press")
joel = Attendee.create(name: "Joel", cosplay: false, attendee_status: "Press")
matt = Attendee.create(name: "Matt", cosplay: true, costume: "Hulk", attendee_status: "Non-Press")
shane = Attendee.create(name: "Shane", cosplay: true, costume:"Jon Snow, King of the North", attendee_status: "Non-press")

long_claw = Merchandise.create( name: "Long Claw", description: "Valeryan Steel Sword Replica", price: 50.99, inventory: 15, booth_id: 1)
dragon_ball = Merchandise.create( name: "Dragon Ball", description: "Golden orb with 4 stars glowing inside", price: 13.99, inventory: 90, booth_id: 2)
pokeball = Merchandise.create( name: "Pokeball", description: "Pokemon Storage Device", price: 9.99, inventory: 5, booth_id: 3)

p1 = Purchase.create(attendee_id: kenny.id , merchandise_id: dragon_ball.id)
p2 = Purchase.create(attendee_id: brian.id, merchandise_id: pokeball.id)
p3 = Purchase.create(attendee_id: shane.id, merchandise_id: long_claw.id)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: "Ben",
 						last_name: "Jervis",
						phone_number: "0401917573".to_i,
						address: "U4 22-24 New Dapto Road, Wollongong, NSW",
						email: "ben@jervis.net.au",
						dob: Date.parse("1993-02-12"),
						level: "staff");

User.create(first_name: "Test",
 						last_name: "User 1",
						phone_number: "0412345678".to_i,
						address: "123 Test Street, Keiraville, Wollongong, NSW",
						email: "testuser1@example.com",
						dob: Date.parse("1993-05-10"),
						level: "visitor");

Group.create(	name: "Test Group 1",
							group_type: "Family");

Group.create(	name: "Test Group 2",
							group_type: "Study Group");

Group.create(	name: "Children's Ministry",
							group_type: "Staff Group");


User.first.add_to([1, 2])

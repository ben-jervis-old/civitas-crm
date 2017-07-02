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
						level: "staff",
            password: 'password',
            password_confirmation: 'password')

User.create(first_name: "James",
 						last_name: "Nicholls",
						phone_number: "0412345678".to_i,
						address: "123 Test Street, Keiraville, Wollongong, NSW",
						email: "james@civitascrm.com.au",
						dob: Date.parse("1993-05-10"),
						level: "leader",
            password: 'password',
            password_confirmation: 'password')

User.create(first_name: "Hayden",
 						last_name: "McWilliams",
						phone_number: "0434567891".to_i,
						address: "7 Crown Street, Wollongong, NSW",
						email: "hayden@civitascrm.com.au",
						dob: Date.parse("1991-06-30"),
						level: "trusted",
            password: 'password',
            password_confirmation: 'password')

User.create(first_name: "Matthew",
 						last_name: "Moore",
						phone_number: "0498765432".to_i,
						address: "34 Keira Street, Wollongong, NSW",
						email: "matt@civitascrm.com.au",
						dob: Date.parse("1995-11-05"),
						level: "visitor",
            password: 'password',
            password_confirmation: 'password')

Group.create(	name: "Test Group 1",
							group_type: "Family")

Group.create(	name: "Test Group 2",
							group_type: "Study Group")

Group.create(	name: "Children's Ministry",
							group_type: "Staff Group")

Group.create( name: "Development Team",
              group_type: "Staff Group")


User.first.add_to([1, 2])

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
total_num_of_customers = 20
total_num_of_restaurants = 10
total_num_of_shippers = 5
total_num_of_foods = 40
total_num_of_comments = 50
total_num_of_orders = 50
addresses = [
    "2838 Crenshaw Blvd",
    "695 S Western Ave",
    "1007 N Western Ave",
    "5450 Sunset Blvd",
    "1800 S Western Ave",
    "3454 Wilshire Blvd",
    "2215 W Martin Luther King Jr Blvd",
    "4166 Melrose Ave",
    "341 S Vermont Ave",
    "1660 Venice Blvd",
    "690 Alameda St",
    "4348 Sunset Blvd",
    "2020 W Olympic Blvd",
    "943 Santee St",
    "1311 W Washington Blvd",
    "1071 W Martin Luther King Jr Blvd",
    "1231 S La Brea Ave",
    "692 S Alvarado St",
    "1625 Wilshire Blvd",
    "2810 S Figueroa St",
    "1440 W PACIFIC COAST",
    "3060 SEPULVEDA BLVD."
]

restaurants = [
    "A&W Restaurants",
    "Arby's",
    "Applebee's",
    "Bakers Square",
    "Baskin-Robbins",
    "Beef O'Brady's",
    "Ben & Jerry's",
    "Benihana",
    "Big Boy",
    "Bertucci's",
    "Feast"
    ]
    
foods = [
    "Bagel",
    "Brown bread",
    "Omelette",
    "Scrambled eggs",
    "Sandwich",
    "Hamburger"
    ]
#Create customers
total_num_of_customers.times do |cus|
  user = User.create(
    email: "customer_" + (cus + 1).to_s + "@example.com",
    password: "88888888",
    password_confirmation: "88888888",
    role: "Customer"
  )
  customer = Customer.create(
      name: "Customer_" + (cus + 1).to_s,
      address: addresses[cus],
      zip: 90024,
      phone: 1234567890,
      user_id: user.id
    )
end

#Create restaurants
total_num_of_restaurants.times do |res|
  user = User.create(
    email: "restaurant_" + (res + 1).to_s + "@example.com",
    password: "88888888",
    password_confirmation: "88888888",
    role: "Restaurant"
  )
  restaurant = Restaurant.create(
      name: restaurants[res],
      address: addresses[res],
      zip: 90024,
      phone: 1234567890,
      user_id: user.id
    )
end

#Create shipper
total_num_of_shippers.times do |ship|
  user = User.create(
    email: "shipper_" + (ship + 1).to_s + "@example.com",
    password: "88888888",
    password_confirmation: "88888888",
    role: "Shipper"
  )
  shipper = Shipper.create(
      name: "shipper_" + (ship + 1).to_s,
      address: addresses[rand(22)],
      zip: 90024,
      phone: 1234567890,
      user_id: user.id
    )   
end

#Create food
total_num_of_foods.times do |food|
    Food.create(
      name: foods[rand(6)],
      price: rand(30) + 1,
      num_left: rand(200) + 1,
      description: "Delicious",
      restaurant_id: rand(total_num_of_restaurants) + 1
    )   
end

#Create comments
total_num_of_comments.times do |comment|
    Comment.create(
      message: "Good!",
      rating: rand(6),
      restaurant_id: rand(total_num_of_restaurants) + 1,
      customer_id: rand(total_num_of_customers) + 1
    )   
end

#Create orders
total_num_of_orders.times do |order|
    Order.create(
      price: rand(100) + 1,
      paid: true,
      ready: false,
      assigned: false,
      arrived: false,
      address: addresses[rand(20)],
      zip:90024,
      phone:1234567890,
      restaurant_id: rand(total_num_of_restaurants) + 1,
      user_id: rand(total_num_of_customers) + 1
    )   
end
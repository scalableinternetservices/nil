# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
total_num_of_customers = 200
total_num_of_restaurants = 30
total_num_of_shippers = 30
total_num_of_foods = 500
total_num_of_comments = 1000000
total_num_of_pending_orders_per_restaurant = 5
total_num_of_confirmed_orders = 500000
#22
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
#32
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
    "Cheesecake Factory",
    "Chick-fil-A",
    "Chili's",
    "Chronic Tacos",
    "Church's",
    "CiCi's Pizza",
    "Country Buffet",
    "Denny's",
    "Elephant Bar",
    "Farmer Boys",
    "Fatburger",
    "Fresh Choice",
    "Friendly's",
    "Hardee's",
    "In-N-Out Burger",
    "Jamba Juice",
    "Jack's",
    "Jet's Pizza",
    "KFC",
    "Luby's",
    "Mr. Hero",
    "Feast"
    ]
#17
foods = [
    "Bagel",
    "Brown bread",
    "Omelette",
    "Scrambled eggs",
    "Sandwich",
    "Hamburger",
    "Coco Cola",
    "Juice",
    "French Fries",
    "Pizza",
    "Soup",
    "Apple",
    "Pie",
    "Panini",
    "Salad",
    "Boba Tea",
    "Taco"
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
      address: addresses[rand(22)],
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
      address: addresses[rand(22)],
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
      name: foods[rand(17)],
      price: rand(30) + 1,
      num_left: rand(200) + 1,
      description: "Delicious",
      image: "default.jpg",
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
total_num_of_restaurants.times do |res|
  total_num_of_pending_orders_per_restaurant.times do |order|
    restaurant = Restaurant.find(res + 1)
    foods = restaurant.foods
    food_id = foods.pluck(:id).sample
    Order.create(
      price: rand(100) + 1,
      paid: true,
      ready: false,
      assigned: false,
      arrived: false,
      address: addresses[rand(22)],
      zip:90024,
      phone:1234567890,
      restaurant_id: restaurant.id,
      user_id: rand(total_num_of_customers) + 1,
      food_json: "[{\"id\":\"#{food_id}\",\"count\":1,\"price\":\"10\"}]"
    )   
  end
end

total_num_of_confirmed_orders.times do |order|
  food = Food.find(rand(total_num_of_foods) + 1)
  restaurant = food.restaurant_id
    Order.create(
      price: rand(100) + 1,
      paid: true,
      ready: true,
      assigned: false,
      arrived: false,
      address: addresses[rand(22)],
      zip:90024,
      phone:1234567890,
      restaurant_id: restaurant,
      user_id: rand(total_num_of_customers) + 1,
      confirmed_at: 0.days.ago,
      food_json: "[{\"id\":\"#{food.id}\",\"count\":1,\"price\":\"#{food.price}\"}]"
    )   
end
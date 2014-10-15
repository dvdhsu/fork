# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "admin@example.com",
    password: "1234",
    password_confirmation: "1234",
    admin: true
)
u.skip_confirmation!
u.save!

# Test user accounts
(1..10).each do |i|
  u = User.new(
      email: "user#{i}@example.com",
      password: "1234",
      password_confirmation: "1234"
  )
  u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)

end
  
# Start with Hugh's
c = College.create!(name: "st-hughs")

# Hugh's mealtimes are fixed
start_date = DateTime.new(2014, 9, 28)
end_date = DateTime.new(2015, 9, 18)

start_date.upto(end_date) do |date|
  def random_meat
    lunch_titles = ["lasanga", "bangers and mash", "beef cobbler", "game pie",
                    "pie and mash", "ploughman's lunch", "shepherd's pie", 
                    "lamb tagine", "breaded fish cake", "breaded fresh haddock",
                    "peppered pork escalope", "beef bolognaise", "braised chicken"]
    lunch_descs = ["Meat, and cheese. Three layers of each.", "Bang them, then mash them.",
                   "It's like a peach cobbler, but with beef.", "You got game? I got pie.",
                   "Yep. It's pie again. This time, though, it's mashed.", "I don't recommend this.",
                   "If a shepherd made a pie, it'd probably be like this.", 
                   "It's exotic, since it's from Morocco.", "Imagine you had a cake, made of fish. Here it is.",
                   "It's like a breaded fish cake, but it's not a cake.", "A hot pig.",
                   "Probably worse than your mum's.", "What happens when you braise a chicken? Give it a try here."]
    index = rand(13)
    return lunch_titles[index], lunch_descs[index]
  end

  def random_veg
    lunch_titles = ["vegetable lasanga", "nut roast with Yorkshire pudding", "cheese, potato, and onion strudel",
                    "mushroom risotto", "root vegetable gratin", "breaded quorn escalope", "cheese tortellini",
                    "mushroom and pepper stroganoff", "rost vegetable encroute", "leek and cheese crumble"]
    index = rand(10)
    return lunch_titles[index], ""
  end

  lunch = c.meals.create!(meal_type: "lunch", start_date: date.change(hour: 12, min: 30), end_date: date.change(hour: 13))

  lunch_notify_time = lunch.start_date.advance(hours: -3)

  #RoostWorker.perform_at(lunch_notify_time, lunch.id)

  dinner = c.meals.create!(meal_type: "dinner", start_date: date.change(hour: 18), end_date: date.change(hour: 19, min: 15))

  dinner_notify_time = dinner.start_date.advance(hours: -3)

  #RoostWorker.perform_at(dinner_notify_time, dinner.id)

  lunch_meat = random_meat
  lunch_veg = random_veg

  lunch.menu_items.create!(price_cents: 190,
                           food_type: "main_meat",
                           title: lunch_meat[0],
                           body: lunch_meat[1])
  lunch.menu_items.create!(price_cents: 150,
                           food_type: "main_veg",
                           title: lunch_veg[0],
                           body: lunch_veg[1])

  dinner_meat = random_meat
  dinner_veg = random_veg

  dinner.menu_items.create!(price_cents: 190,
                           food_type: "main_meat",
                           title: dinner_meat[0],
                           body: dinner_meat[1])
  dinner.menu_items.create!(price_cents: 190,
                           food_type: "main_veg",
                           title: dinner_veg[0],
                           body: dinner_veg[1])
end

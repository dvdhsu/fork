# Generated with RailsBricks

# Admin account
u = User.new(
    email: ENV["ADMIN_EMAIL"],
    password: ENV["ADMIN_PASSWORD"],
    password_confirmation: ENV["ADMIN_PASSWORD"],
    admin: true
)
u.skip_confirmation!
u.save!
  
# Start with Hugh's
c = College.create!(name: "st-hughs")

# Hugh's mealtimes are fixed
start_date = DateTime.new(2014, 11, 20)
end_date = DateTime.new(2015, 9, 18)

def is_weekend(d)
  return d.saturday? || d.sunday?
end

def random_meat
  lunch_titles = ["lasanga", "bangers and mash", "beef cobbler", "game pie",
                  "pie and mash", "ploughman's lunch", "shepherd's pie",
                  "lamb tagine", "breaded fish cake", "breaded fresh haddock",
                  "peppered pork escalope", "beef bolognaise", "braised chicken"]
  index = rand(13)
  return lunch_titles[index], ""
end

def random_veg
  lunch_titles = ["vegetable lasanga", "nut roast with Yorkshire pudding", "cheese, potato, and onion strudel",
                  "mushroom risotto", "root vegetable gratin", "breaded quorn escalope", "cheese tortellini",
                  "mushroom and pepper stroganoff", "rost vegetable encroute", "leek and cheese crumble"]
  index = rand(10)
  return lunch_titles[index], ""
end

start_date.upto(end_date) do |date|
  # no meals on weekends for Hugh's
  if is_weekend date
    next
  end

  lunch = c.meals.create!(meal_type: "lunch", start_date: date.change(hour: 12, min: 30), end_date: date.change(hour: 13))

  lunch_notify_time = lunch.start_date.advance(hours: -3)

  RoostWorker.perform_at(lunch_notify_time, lunch.id)

  dinner = c.meals.create!(meal_type: "dinner", start_date: date.change(hour: 18), end_date: date.change(hour: 19, min: 15))

  dinner_notify_time = dinner.start_date.advance(hours: -3)

  RoostWorker.perform_at(dinner_notify_time, dinner.id)

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

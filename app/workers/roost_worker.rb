class RoostWorker
  include Sidekiq::Worker

  def perform(meal_id)
    conn = Faraday::Connection.new 'https://go.goroost.com'
    conn.basic_auth(ENV['ROOST_USERNAME'], ENV['ROOST_PASSWORD'])

    meal = Meal.find(meal_id)
    type = meal.meal_type

    veg = meal.menu_items.where(food_type: "main_veg")[0]
    meat = meal.menu_items.where(food_type: "main_meat")[0]

    push_body = {
      alert: "For " + type + ", there's " +
             meat.title + ", and " + veg.title + ".", 
      url: "https://notifsta.com",
      segments: [type]
    }.to_json
    send_alert(conn, push_body)

=begin
    veg_body = { 
      alert: "For " + type + ", the vegeterian option is " +
              veg.title + ". " + veg.body,
      url: "https://google.com",
      segments: [type + "_veg"]
    }.to_json
    send_alert(conn, veg_body)

    # sleep for five seconds to allow the previous notification to be read
    sleep 5

    meat_body = { 
      alert: "For " + type + ", the meat option is " +
              meat.title + ". " + meat.body,
      url: "https://google.com",
      segments: [type + "_meat"]
    }.to_json
    send_alert(conn, meat_body)
=end
  end

  private
    def send_alert(conn, body)
      conn.post do |req|
        req.url 'api/push'
        req.headers['Content-Type'] = 'application/json'
        req.body = body
      end
    end
end

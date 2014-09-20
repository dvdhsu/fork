class MenuItem < ActiveRecord::Base
  belongs_to :meal
  monetize :price_cents
end

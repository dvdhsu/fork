class Meal < ActiveRecord::Base
  belongs_to :college
  has_many :menu_items
end

class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :meal_type
      t.references :college, index: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
    add_index :meals, :meal_type
  end
end

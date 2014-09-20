class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :type
      t.references :college, index: true
      t.datetime :date

      t.timestamps
    end
    add_index :meals, :type
  end
end

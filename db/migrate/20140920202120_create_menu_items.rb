class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :food_type
      t.string :title
      t.string :body
      t.integer :price_cents
      t.references :meal, index: true

      t.timestamps
    end
  end
end

class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :type
      t.string :desc
      t.integer :price_cents
      t.references :meal, index: true

      t.timestamps
    end
  end
end

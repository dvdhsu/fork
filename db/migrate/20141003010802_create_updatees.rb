class CreateUpdatees < ActiveRecord::Migration
  def change
    create_table :updatees do |t|
      t.string :email
      t.boolean :ios
      t.boolean :android

      t.timestamps
    end
  end
end

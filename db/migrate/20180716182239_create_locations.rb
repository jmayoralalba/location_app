class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name,       null: false, limit: 255
      t.string :phone,      null: false, limit: 255
      t.string :address,    null: false
      t.string :postcode,   null: false, limit: 255
      t.string :city,       null: false, limit: 255
      t.string :country,    null: false, limit: 255

      t.decimal :latitude,  null: false, precision: 15, scale: 13
      t.decimal :longitude, null: false, precision: 15, scale: 13

      t.timestamps
    end
  end
end

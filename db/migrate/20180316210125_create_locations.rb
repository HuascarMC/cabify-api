class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.decimal :lon
      t.decimal :lat
      t.references :cab, foreign_key: true

      t.timestamps
    end
  end
end

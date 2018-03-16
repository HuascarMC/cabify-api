class CreateCabs < ActiveRecord::Migration[5.1]
  def change
    create_table :cabs do |t|
      t.string :state
      t.string :name
      t.string :city

      t.timestamps
    end
  end
end

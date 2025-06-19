# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate, unique: true
      t.string :make
      t.string :model
      t.integer :year
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

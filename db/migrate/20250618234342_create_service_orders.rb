# frozen_string_literal: true

class CreateServiceOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :service_orders do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.references :maintenance_report, null: false, foreign_key: true
      t.date :creation_date
      t.integer :status, default: 0
      t.decimal :estimated_cost, default: 0.0, precision: 10, scale: 2

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateMaintenanceReports < ActiveRecord::Migration[8.0]
  def change
    create_table :maintenance_reports do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.string :description
      t.date :report_date
      t.integer :priority, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

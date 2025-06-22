# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

25.times do |i|
  Vehicle.find_or_create_by!(
    license_plate: Faker::Vehicle.license_plate(state_abbreviation: 'CA'),
    make: Faker::Vehicle.make,
    model: (m = Faker::Vehicle.model; m = m.length < 2 ? 'AA' : m[0..7]),
    status: :available,
    year: Faker::Vehicle.year
  )
  puts "Vehicle #{i + 1} created"
end

25.times do |i|
  MaintenanceReport.find_or_create_by!(
    description: Faker::Lorem.sentence,
    priority: Random.rand(0..2),
    report_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    status: Random.rand(0..2),
    vehicle_id: Vehicle.pluck(:id).sample
  )
  puts "MaintenanceReport #{i + 1} created"
end

15.times do |i|
  maintenance_report = MaintenanceReport.all.sample
  next unless maintenance_report

  ServiceOrder.find_or_create_by!(
    creation_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
    estimated_cost: Faker::Number.decimal(l_digits: 2),
    status: :open,
    maintenance_report_id: maintenance_report.id,
    vehicle_id: maintenance_report.vehicle_id
  )
  puts "ServiceOrder #{i + 1} created"
end

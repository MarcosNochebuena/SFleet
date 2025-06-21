# == Schema Information
#
# Table name: vehicles
#
#  id            :bigint           not null, primary key
#  license_plate :string
#  make          :string
#  model         :string
#  status        :integer
#  year          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  let(:vehicle) { FactoryBot.create(:vehicle, license_plate: "ABC123", make: "Toyota", model: "Hilux", year: 2022) }
  it "has a valid factory" do
    expect(FactoryBot.build(:vehicle)).to be_valid
  end

  describe "license plate validations" do
    context "valid cases" do
      valid_cases = {
        "ABC123" => true,
        "ABC1234" => true,
        "ABC12345" => true,
      }

      valid_cases.each do |license_plate, message|
        it "is valid with license plate #{license_plate}" do
          vehicle = FactoryBot.build(:vehicle, license_plate: license_plate)
          expect(vehicle).to be_valid
        end
      end
    end

    context "invalid cases" do
      invalid_cases = {
        nil => "can't be blank",
        "" => "can't be blank",
        0 => "must be 6-8 alphanumeric characters",
        " " => "can't be blank",
        "123" => "must be 6-8 alphanumeric characters",
        "123456789" => "must be 6-8 alphanumeric characters",
        "ABCDE1234" => "must be 6-8 alphanumeric characters",
        "ABCD" => "must be 6-8 alphanumeric characters",
        "*/*/" => "must be 6-8 alphanumeric characters",
      }

      invalid_cases.each do |license_plate, message|
        it "is invalid with license plate #{license_plate}" do
          vehicle = FactoryBot.build(:vehicle, license_plate: license_plate)
          expect(vehicle).to be_invalid
          expect(vehicle.errors[:license_plate]).to include(message)
        end
      end

      it "is invalid with a duplicate license plate" do
        vehicle = FactoryBot.create(:vehicle, license_plate: "ABC123")
        expect(FactoryBot.build(:vehicle, license_plate: "ABC123")).to be_invalid
      end
    end
  end

  describe "make validations" do
    context "valid cases" do
      valid_cases = {
        "Toyota" => true,
        "Honda" => true,
        "Ford" => true,
        "BMW" => true,
      }

      valid_cases.each do |make, message|
        it "is valid with make #{make}" do
          vehicle = FactoryBot.build(:vehicle, make: make)
          expect(vehicle).to be_valid
        end
      end
    end

    context "invalid cases" do
      invalid_cases = {
        nil => "can't be blank",
        "" => "can't be blank",
        0 => "must be 3-8 letters or numbers",
        " " => "can't be blank",
        "123" => "must be 3-8 letters or numbers",
        "123456789" => "must be 3-8 letters or numbers",
        "ABCDE1234" => "must be 3-8 letters or numbers",
        "AB" => "must be 3-8 letters or numbers",
        "*/*/" => "must be 3-8 letters or numbers",
      }

      invalid_cases.each do |make, message|
        it "is invalid with make #{make}" do
          vehicle = FactoryBot.build(:vehicle, make: make)
          expect(vehicle).to be_invalid
          expect(vehicle.errors[:make]).to include(message)
        end
      end
    end
  end

  describe "model validations" do
    context "valid cases" do
      valid_cases = {
        "Camry" => true,
        "Civic" => true,
        "Mustang" => true,
        "i3" => true,
      }

      valid_cases.each do |model, message|
        it "is valid with model #{model}" do
          vehicle = FactoryBot.build(:vehicle, model: model)
          expect(vehicle).to be_valid
        end
      end
    end

    context "invalid cases" do
      invalid_cases = {
        nil => "can't be blank",
        "" => "can't be blank",
        0 => "must be 2-8 letters or numbers",
        " " => "can't be blank",
        "123456789" => "must be 2-8 letters or numbers",
        "ABCDE1234" => "must be 2-8 letters or numbers",
        "*/*/" => "must be 2-8 letters or numbers",
      }

      invalid_cases.each do |model, message|
        it "is invalid with model #{model}" do
          vehicle = FactoryBot.build(:vehicle, model: model)
          expect(vehicle).to be_invalid
          expect(vehicle.errors[:model]).to include(message)
        end
      end
    end
  end

  describe "year validations" do
    context "valid cases" do
      valid_cases = {
        2022 => true,
        2023 => true,
        2024 => true,
        2025 => true,
      }

      valid_cases.each do |year, message|
        it "is valid with year #{year}" do
          vehicle = FactoryBot.build(:vehicle, year: year)
          expect(vehicle).to be_valid
        end
      end
    end

    context "invalid cases" do
      invalid_cases = {
        nil => "can't be blank",
        "" => "can't be blank",
        0 => "must be greater than or equal to 1900",
        " " => "can't be blank",
        "ABCDE1234" => "is not a number",
        "AB" => "is not a number",
        "*/*/" => "is not a number",
        2026 => "must be less than or equal to #{Date.today.year}",
        1899 => "must be greater than or equal to 1900",
      }

      invalid_cases.each do |year, message|
        it "is invalid with year #{year}" do
          vehicle = FactoryBot.build(:vehicle, year: year)
          expect(vehicle).to be_invalid
          expect(vehicle.errors[:year]).to include(message)
        end
      end
    end

    context "enum validations" do
      valid_cases = {
        available: true,
        in_service: true,
        in_maintenance: true,
        out_of_service: true,
        0 => true,
        1 => true,
        'available' => true,
        'in_service' => true,
      }

      valid_cases.each do |status, message|
        it "is valid with status #{status}" do
          vehicle = FactoryBot.build(:vehicle, status: status)
          expect(vehicle).to be_valid
        end
      end
    end

    context "invalid cases" do
      invalid_cases = {
        nil => "can't be blank",
        "" => "can't be blank",
      }

      invalid_cases.each do |status, message|
        it "is invalid with status #{status}" do
          vehicle = FactoryBot.build(:vehicle, status: status)
          expect(vehicle).to be_invalid
          expect(vehicle.errors[:status]).to include(message)
        end
      end

      invalid_statuses = {
        'sold' => "'sold' is not a valid status",
        8 => "'8' is not a valid status",
        '.' => "'.' is not a valid status"
      }

      invalid_statuses.each do |status, message|
        it "raises error with invalid status #{status.inspect}" do
          vehicle = FactoryBot.build(:vehicle)
          expect { vehicle.status = status }.to raise_error(ArgumentError, message)
        end
      end
    end
  end
  describe "validate scopes" do
    let(:available_vehicle) { FactoryBot.create(:vehicle, status: :available) }
    let(:in_service_vehicle) { FactoryBot.create(:vehicle, status: :in_service) }
    let(:in_maintenance_vehicle) { FactoryBot.create(:vehicle, status: :in_maintenance) }
    let(:out_of_service_vehicle) { FactoryBot.create(:vehicle, status: :out_of_service) }

    context ".status" do
      it "return only available vehicles" do
        expect(Vehicle.available).to eq([available_vehicle])
        expect(Vehicle.available).not_to include(in_service_vehicle, in_maintenance_vehicle, out_of_service_vehicle)
      end

      it "return only in_service vehicles" do
        expect(Vehicle.in_service).to eq([in_service_vehicle])
        expect(Vehicle.in_service).not_to include(available_vehicle, in_maintenance_vehicle, out_of_service_vehicle)
      end

      it "return only in_maintenance vehicles" do
        expect(Vehicle.in_maintenance).to eq([in_maintenance_vehicle])
        expect(Vehicle.in_maintenance).not_to include(in_service_vehicle, available_vehicle, out_of_service_vehicle)
      end

      it "return only out_of_service vehicles" do
        expect(Vehicle.out_of_service).to eq([out_of_service_vehicle])
        expect(Vehicle.out_of_service).not_to include(in_service_vehicle, in_maintenance_vehicle, available_vehicle)
      end
    end

    context "filter by license_plate" do
      it "returns only vehicle id param" do
        expect(Vehicle.where(license_plate: "ABC123")).to eq([vehicle])
        expect(Vehicle.where(license_plate: 50)).to be_empty
      end
    end

    context "filter by make" do
      it "returns only vehicle make param" do
        expect(Vehicle.where(make: "Toyota")).to eq([vehicle])
        expect(Vehicle.where(make: 50)).to be_empty
      end
    end

    context "filter by model" do
      it "returns only vehicle model param" do
        expect(Vehicle.where(model: "Hilux")).to eq([vehicle])
        expect(Vehicle.where(model: 50)).to be_empty
      end
    end

    context "filter by year" do
      it "returns only vehicle year param" do
        expect(Vehicle.where(year: 2022)).to eq([vehicle])
        expect(Vehicle.where(year: 50)).to be_empty
      end
    end

    context "filter by status" do
      it "returns only vehicle status param" do
        expect(Vehicle.where(status: :available)).to eq([vehicle])
        expect(Vehicle.where(status: 50)).to be_empty
      end
    end
  end
end

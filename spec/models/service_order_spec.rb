# == Schema Information
#
# Table name: service_orders
#
#  id                    :bigint           not null, primary key
#  creation_date         :date
#  estimated_cost        :decimal(10, 2)   default(0.0)
#  status                :integer          default(0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  maintenance_report_id :bigint           not null
#  vehicle_id            :bigint           not null
#
# Indexes
#
#  index_service_orders_on_maintenance_report_id  (maintenance_report_id)
#  index_service_orders_on_vehicle_id             (vehicle_id)
#
# Foreign Keys
#
#  fk_rails_...  (maintenance_report_id => maintenance_reports.id)
#  fk_rails_...  (vehicle_id => vehicles.id)
#
require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  let(:valid_vehicle) { FactoryBot.create(:vehicle) }
  let(:valid_report) { FactoryBot.create(:maintenance_report) }
  let(:service_order) { FactoryBot.create(:service_order, maintenance_report: valid_report, vehicle: valid_vehicle, creation_date: Date.current, estimated_cost: 100) }

  it "has a valid factory" do
    expect(FactoryBot.build(:service_order)).to be_valid
  end

  describe "creation date validations" do
    context "valid cases" do
      valid_cases = {
        Date.current => true,
        Date.current.to_s => true,
        DateTime.now.to_s => true,
        Date.yesterday => true,
        "2025-06-20" => true,
        "2025-06-20 12:00:00" => true,
        "20250620" => true,
      }
      valid_cases.each do |creation_date, message|
        it "is valid with creation date #{creation_date}" do
          service_order = FactoryBot.build(:service_order, creation_date: creation_date)
          expect(service_order).to be_valid
        end
      end
    end

    context "invalid cases" do
      invalid_cases = {
        nil => "can't be blank",
        " " => "can't be blank",
        Date.tomorrow => "Creation date must be a valid date",
        (Date.tomorrow).to_s => "Report date must be a valid date",
        "hoy" => "Creation date must be a valid date",
        (DateTime.tomorrow).to_s => "Creation date must be a valid date",
        20250620 => "Creation date must be a valid date",
      }
      invalid_cases.each do |creation_date, message|
        it "is invalid with creation date #{creation_date}" do
          service_order = FactoryBot.build(:service_order, creation_date: creation_date)
          expect(service_order).to be_invalid
        end
      end
    end
  end
  describe "estimated cost validations" do
    context "valid cases" do
      valid_cases = {
        0 => true,
        10000 => true,
        '0' => true,
        0.0 => true,
        50.25 => true,
        500000.00 => true,
      }
      valid_cases.each do |estimated_cost, message|
        it "is valid with creation date #{estimated_cost}" do
          service_order = FactoryBot.build(:service_order, estimated_cost: estimated_cost)
          expect(service_order).to be_valid
        end
      end
    end

    context "invalid cases" do
      invalid_cases = {
        nil => "can't be blank",
        " " => "can't be blank",
        -1 => "Estimated cost must be between 0 and 1000000",
        1000001 => "Estimated cost must be between 0 and 1000000",
        5000000000 => "Estimated cost must be between 0 and 1000000",
        "abc" => "Estimated cost must be a number",
        "1000.50.25" => "Estimated cost must be a number",
        "1000,50" => "Estimated cost must be a number",
        "1000.50,25" => "Estimated cost must be a number",
        "." => "Estimated cost must be a number",
        "-0.1" => "Estimated cost must be a number",
      }
      invalid_cases.each do |estimated_cost, message|
        it "is invalid with creation date #{estimated_cost}" do
          service_order = FactoryBot.build(:service_order, estimated_cost: estimated_cost)
          expect(service_order).to be_invalid
        end
      end
    end
  end

  describe "enum validations" do
    context "valid cases" do
      valid_cases = {
        :open => true,
        :in_progress => true,
        :closed => true,
        0 => true,
        1 => true,
        2 => true,
        'open' => true,
        'in_progress' => true,
        'closed' => true,
      }

      valid_cases.each do |status, message|
        it "is valid with status #{status}" do
          service_order = FactoryBot.build(:service_order, status: status)
          expect(service_order).to be_valid
        end
      end
    end
    context "invalid cases" do
      invalid_cases = {
        nil => "cant't be blank",
        "" => "cant't be blank",
      }

      invalid_cases.each do |status, message|
        it "is invalid with status #{status}" do
          service_order = FactoryBot.build(:service_order, status: status)
          expect(service_order).to be_invalid
        end
      end

      invalid_statuses = {
        'refused' => "'refused' is not a valid status",
        8 => "'8' is not a valid status",
        '.' => "'.' is not a valid status",
        :refused => "'refused' is not a valid status",
      }

      invalid_statuses.each do |status, message|
        it "raises error with invalid status #{status}" do
          service_order = FactoryBot.build(:service_order)
          expect { service_order.status = status }.to raise_error(ArgumentError, message)
        end
      end
    end
  end

  describe "validate vehicle id" do
    context "valid cases" do
      it "is valid with an existing vehicle" do
        service_order = FactoryBot.build(:service_order, vehicle: valid_vehicle)
        expect(service_order).to be_valid
      end

      it "is valid with an existing maintenance report" do
        service_order = FactoryBot.build(:service_order, maintenance_report: valid_report)
        expect(service_order).to be_valid
      end

      it "is valid with an existing vehicle and maintenance report" do
        service_order = FactoryBot.build(:service_order, vehicle: valid_vehicle, maintenance_report: valid_report)
        expect(service_order).to be_valid
      end
    end

    context "invalid cases" do
      it "is invalid without a vehicle" do
        service_order = FactoryBot.build(:service_order, vehicle: nil)
        expect(service_order).to be_invalid
        expect(service_order.errors[:vehicle]).to include("must exist")
      end

      it "is invalid without a maintenance_report" do
        service_order = FactoryBot.build(:service_order, maintenance_report: nil)
        expect(service_order).to be_invalid
        expect(service_order.errors[:maintenance_report]).to include("must exist")
      end

      it "is invalid without a vehicle and a maintenance_report" do
        service_order = FactoryBot.build(:service_order, maintenance_report: nil, vehicle: nil)
        expect(service_order).to be_invalid
        expect(service_order.errors[:vehicle]).to include("must exist")
        expect(service_order.errors[:maintenance_report]).to include("must exist")
      end
    end
  end

  describe "validate scopes" do
    let(:open_service) { FactoryBot.create(:service_order, status: :open, maintenance_report: valid_report, vehicle: valid_vehicle) }
    let(:in_progress_service) { FactoryBot.create(:service_order, status: :in_progress, maintenance_report: valid_report, vehicle: valid_vehicle) }
    let(:closed_service) { FactoryBot.create(:service_order, status: :closed, maintenance_report: valid_report, vehicle: valid_vehicle) }

    context ".status" do
      it "returns only open service orders" do
        expect(ServiceOrder.open).to eq([open_service])
        expect(ServiceOrder.open).not_to include(in_progress_service, closed_service)
      end
      it "returns only in_progress service orders" do
        expect(ServiceOrder.in_progress).to eq([in_progress_service])
        expect(ServiceOrder.in_progress).not_to include(open_service, closed_service)
      end
      it "returns only closed service orders" do
        expect(ServiceOrder.closed).to eq([closed_service])
        expect(ServiceOrder.closed).not_to include(in_progress_service, open_service)
      end
    end

    context "filter by vehicle_id" do
      it "returns only vehicle id param" do
        expect(ServiceOrder.where(vehicle: valid_vehicle)).to eq([service_order])
        expect(ServiceOrder.where(vehicle: 50)).to be_empty
      end
    end

    context "filter by maintenance_report_id" do
      it "returns only maintenance_report id param" do
        expect(ServiceOrder.where(maintenance_report: valid_report)).to eq([service_order])
        expect(ServiceOrder.where(maintenance_report: 50)).to be_empty
      end

    end

    context "filter by creation_date" do
      it "returns only creation_date id param" do
        expect(ServiceOrder.where(creation_date: Date.current)).to eq([service_order])
        expect(ServiceOrder.where(creation_date: Date.tomorrow)).to be_empty
      end
    end

    context "filter by estimated_cost" do
      it "returns only estimated_cost id param" do
        expect(ServiceOrder.where(estimated_cost: 100)).to eq([service_order])
        expect(ServiceOrder.where(estimated_cost: 0)).to be_empty
      end
    end

    context "filter by status" do
      it "returns only status id param" do
        expect(ServiceOrder.where(status: :open)).to eq([service_order])
        expect(ServiceOrder.where(status: 50)).to be_empty
      end
    end
  end

  describe "validate callbacks" do
    before do
      ActiveJob::Base.queue_adapter = :test
      ActiveJob::Base.queue_adapter.enqueued_jobs.clear
    end

    context "when status is open" do
      let(:open_service) { FactoryBot.build(:service_order, maintenance_report: valid_report, vehicle: valid_vehicle, creation_date: Date.current, estimated_cost: 100, status: :open) }

      it 'enqueues SimulateMaintenanceJob after save' do
        expect {
          open_service.save!
        }.to have_enqueued_job(SimulateMaintenanceJob)
          .with(open_service.id)
          .on_queue('default')
      end
    end

    context "when status is not open" do
      let(:in_progress_service) { FactoryBot.build(:service_order, maintenance_report: valid_report, vehicle: valid_vehicle, creation_date: Date.current, estimated_cost: 100, status: :in_progress) }

      it 'does not enqueue SimulateMaintenanceJob' do
        expect {
          in_progress_service.save!
        }.not_to have_enqueued_job(SimulateMaintenanceJob)
      end
    end
  end
end

# == Schema Information
#
# Table name: maintenance_reports
#
#  id          :bigint           not null, primary key
#  description :string
#  priority    :integer          default(0)
#  report_date :date
#  status      :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  vehicle_id  :bigint           not null
#
# Indexes
#
#  index_maintenance_reports_on_vehicle_id  (vehicle_id)
#
# Foreign Keys
#
#  fk_rails_...  (vehicle_id => vehicles.id)
#
require 'rails_helper'

RSpec.describe MaintenanceReport, type: :model do
  let(:maintenance_report) { FactoryBot.create(:maintenance_report, description: "Maintenance Report", report_date: Date.current, priority: 0, status: 0, vehicle: FactoryBot.create(:vehicle)) }
  it "has a valid factory" do
    expect(FactoryBot.build(:maintenance_report)).to be_valid
  end

  describe "validate description" do
    context "valid cases" do
      valid_cases = {
        "Maintenance Report" => true,
        "Maintenance Report 2" => true,
        "El vehículo necesita mantenimiento" => true,
      }

      valid_cases.each do |description, message|
        it "is valid with description #{description}" do
          maintenance_report = FactoryBot.build(:maintenance_report, description: description)
          expect(maintenance_report).to be_valid
        end
      end
    end

    context "invalid cases" do
      invalid_cases = {
        nil => "can't be blank",
        "" => "can't be blank",
      }

      invalid_cases.each do |description, message|
        it "is invalid with description #{description}" do
          maintenance_report = FactoryBot.build(:maintenance_report, description: description)
          expect(maintenance_report).to be_invalid
          expect(maintenance_report.errors[:description]).to include(message)
        end
      end
    end
  end

  describe "validate report_date" do
    context "valid cases" do
      valid_cases = {
        Date.current => true,
        Date.current.to_s => true,
        Date.yesterday => true,
        "2025-06-20" => true,
        "2025-06-20 12:00:00" => true,
        "20250620" => true,
      }

      valid_cases.each do |report_date, message|
        it "is valid with report_date #{report_date}" do
          maintenance_report = FactoryBot.build(:maintenance_report, report_date: report_date)
          expect(maintenance_report).to be_valid
        end
      end
    end

    context "invalid cases" do
      invalid_cases = {
        nil => "can't be blank",
        "" => "can't be blank",
        "hoy" => "Report date must be a valid date",
        20250620 => "comparison of Integer with Time failed",
        Date.tomorrow => "Report date must be a valid date",
        (Date.tomorrow) => "Report date must be a valid date",
        (DateTime.tomorrow)=> "Report date must be a valid date",
        "20251306" => "Report date must be a valid date",
        "/*/*" => "Report date must be a valid date",
      }

      invalid_cases.each do |report_date, message|
        it "is invalid with report_date #{report_date}" do
          maintenance_report = FactoryBot.build(:maintenance_report, report_date: report_date)
          expect(maintenance_report).to be_invalid
          expect(maintenance_report.errors[:report_date]).to include(message)
        end
      end
    end
  end

  describe "validate vehicle_id" do
    context "valid cases" do
      let(:valid_vehicle) { FactoryBot.create(:vehicle) }

      it 'is valid with an existing vehicle' do
        maintenance_report = FactoryBot.build(:maintenance_report, vehicle: valid_vehicle)
        expect(maintenance_report).to be_valid
      end
    end

    context "invalid cases" do
      it "is invalid without a vehicle" do
        maintenance_report = FactoryBot.build(:maintenance_report, vehicle: nil)
        expect(maintenance_report).to be_invalid
        expect(maintenance_report.errors[:vehicle]).to include("must exist")
      end

      it "is invalid with non-existent vehicle_id" do
        maintenance_report = FactoryBot.build(:maintenance_report, vehicle_id: 999999)
        expect(maintenance_report).to be_invalid
        expect(maintenance_report.errors[:vehicle]).to include("must exist")
      end
    end
  end

  describe "validate priority" do
    context "valid cases" do
      valid_cases = {
        0 => true,
        1 => true,
        2 => true,
        'high' => true,
        'medium' => true,
        'low' => true,
        :high => true,
        :medium => true,
        :low => true,
      }

      valid_cases.each do |priority, message|
        it "is valid with priority #{priority}" do
          maintenance_report = FactoryBot.build(:maintenance_report, priority: priority)
          expect(maintenance_report).to be_valid
        end
      end
    end

    context "invalid cases" do
      invalid_cases = {
        nil => "can't be blank",
        "" => "can't be blank",
      }

      invalid_cases.each do |priority, message|
        it "is invalid with priority #{priority}" do
          maintenance_report = FactoryBot.build(:maintenance_report, priority: priority)
          expect(maintenance_report).to be_invalid
          expect(maintenance_report.errors[:priority]).to include(message)
        end
      end

      invalid_priorities = {
        3 => "'3' is not a valid priority",
        -1 => "'-1' is not a valid priority",
      }

      invalid_priorities.each do |priority, message|
        it "is invalid with priority #{priority}" do
          maintenance_report = FactoryBot.build(:maintenance_report)
          expect { maintenance_report.priority = priority }.to raise_error(ArgumentError, message)
        end
      end
    end
  end

  describe "validate status" do
    context "valid cases" do
      valid_cases = {
        0 => true,
        1 => true,
        2 => true,
        'pending' => true,
        'processed' => true,
        'refused' => true,
        :pending => true,
        :processed => true,
        :refused => true,
      }

      valid_cases.each do |status, message|
        it "is valid with status #{status}" do
          maintenance_report = FactoryBot.build(:maintenance_report, status: status)
          expect(maintenance_report).to be_valid
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
          maintenance_report = FactoryBot.build(:maintenance_report, status: status)
          expect(maintenance_report).to be_invalid
          expect(maintenance_report.errors[:status]).to include(message)
        end
      end

      invalid_statuses = {
        3 => "'3' is not a valid status",
        -1 => "'-1' is not a valid status",
      }

      invalid_statuses.each do |status, message|
        it "is invalid with status #{status}" do
          maintenance_report = FactoryBot.build(:maintenance_report)
          expect { maintenance_report.status = status }.to raise_error(ArgumentError, message)
        end
      end
    end
  end

  describe "validate scopes" do
    let(:pending_report) { FactoryBot.create(:maintenance_report, status: :pending) }
    let(:processed_report) { FactoryBot.create(:maintenance_report, status: :processed) }
    let(:refused_report) { FactoryBot.create(:maintenance_report, status: :refused) }

    context ".status" do
      it "returns only pending maintenance reports" do
        expect(MaintenanceReport.pending).to eq([pending_report])
        expect(MaintenanceReport.pending).not_to include(processed_report, refused_report)
      end
      it "returns only processed maintenance reports" do
        expect(MaintenanceReport.processed).to eq([processed_report])
        expect(MaintenanceReport.processed).not_to include(pending_report, refused_report)
      end
      it "returns only refused maintenance reports" do
        expect(MaintenanceReport.refused).to eq([refused_report])
        expect(MaintenanceReport.refused).not_to include(pending_report, processed_report)
      end
    end

    context "filter by vehicle_id" do
      it "returns only vehicle id param" do
        expect(MaintenanceReport.where(vehicle: maintenance_report.vehicle)).to eq([maintenance_report])
        expect(MaintenanceReport.where(vehicle: 50)).to be_empty
      end
    end

    context "filter by report_date" do
      it "returns only report_date id param" do
        expect(MaintenanceReport.where(report_date: Date.current)).to eq([maintenance_report])
        expect(MaintenanceReport.where(report_date: Date.tomorrow)).to be_empty
      end
    end

    context "filter by priority" do
      it "returns only priority id param" do
        expect(MaintenanceReport.where(priority: :high)).to eq([maintenance_report])
        expect(MaintenanceReport.where(priority: 50)).to be_empty
      end
    end

    context "filter by status" do
      it "returns only status id param" do
        expect(MaintenanceReport.where(status: :pending)).to eq([maintenance_report])
        expect(MaintenanceReport.where(status: 50)).to be_empty
      end
    end
  end

  describe "after_save" do
    it "creates a service order when priority is high" do
      maintenance_report = FactoryBot.create(:maintenance_report, priority: :high)
      expect(maintenance_report.reload.service_orders).to eq([maintenance_report.service_orders.first])
    end
    it "does not create a service order when priority is not high" do
      maintenance_report = FactoryBot.create(:maintenance_report, priority: :medium)
      expect(maintenance_report.reload.service_orders).to be_empty
    end
  end
end

require 'rails_helper'

RSpec.describe SimulateMaintenanceJob, type: :job do
  let(:vehicle) { FactoryBot.create(:vehicle) }
  let(:maintenance_report) { FactoryBot.create(:maintenance_report, vehicle: vehicle) }
  let(:service_order) { FactoryBot.create(:service_order, vehicle: vehicle, maintenance_report: maintenance_report) }

  before do
    ActiveJob::Base.queue_adapter = :test
    expect_any_instance_of(SimulateMaintenanceJob).to receive(:sleep).with(10)
  end

  describe "#perform" do
    it "sleeps for 10 seconds" do
      SimulateMaintenanceJob.new.perform(service_order.id)
    end

    it "simulate job" do
      SimulateMaintenanceJob.new.perform(service_order.id)

      expect(vehicle.status).to eq('available')
      expect(maintenance_report.status).to eq('processed')
      expect(service_order.status).to eq('open')
    end

    it "raises error when service order doesn't exist" do
      expect {
        SimulateMaintenanceJob.new.perform(999)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end

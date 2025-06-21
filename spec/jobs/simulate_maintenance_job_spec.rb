require 'rails_helper'

RSpec.describe SimulateMaintenanceJob, type: :job do
  it "should simulate maintenance" do
    expect { SimulateMaintenanceJob.perform_later }.to change(MaintenanceReport, :count).by(1)
  end
end

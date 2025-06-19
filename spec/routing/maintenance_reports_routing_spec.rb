require "rails_helper"

RSpec.describe MaintenanceReportsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/maintenance_reports").to route_to("maintenance_reports#index")
    end

    it "routes to #show" do
      expect(get: "/maintenance_reports/1").to route_to("maintenance_reports#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/maintenance_reports").to route_to("maintenance_reports#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/maintenance_reports/1").to route_to("maintenance_reports#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/maintenance_reports/1").to route_to("maintenance_reports#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/maintenance_reports/1").to route_to("maintenance_reports#destroy", id: "1")
    end
  end
end

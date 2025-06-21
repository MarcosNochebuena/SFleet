require "rails_helper"

RSpec.describe ServiceOrdersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/service_orders").to route_to("service_orders#index")
    end

    it "routes to #show" do
      expect(get: "/service_orders/1").to route_to("service_orders#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/service_orders").to route_to("service_orders#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/service_orders/1").to route_to("service_orders#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/service_orders/1").to route_to("service_orders#update", id: "1")
    end

    it "routes to #update_status via PATCH" do
      expect(patch: "/service_orders/1/status").to route_to("service_orders#update_status", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/service_orders/1").to route_to("service_orders#destroy", id: "1")
    end
  end
end

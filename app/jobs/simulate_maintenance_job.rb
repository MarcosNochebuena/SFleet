class SimulateMaintenanceJob < ApplicationJob
  queue_as :default

  def perform(service_order_id)
    sleep 10

    service_order = ServiceOrder.find(service_order_id)

    service_order.update(status: :closed)
    service_order.vehicle.update(status: :available)
    service_order.maintenance_report.update(status: :processed)
  end
end

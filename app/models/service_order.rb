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
class ServiceOrder < ApplicationRecord
  audited
  belongs_to :vehicle
  belongs_to :maintenance_report

  # Validations
  validates :creation_date, :status, :vehicle_id, :maintenance_report_id, presence: true

  # Enum Status
  enum :status, { open: 0, in_progress: 1, closed: 2 }, default: :open

  # Scopes
  scope :status, ->(status) { where(status: status) }
  scope :vehicle_id, ->(vehicle_id) { where(vehicle_id: vehicle_id) }
  scope :maintenance_report_id, ->(maintenance_report_id) { where(maintenance_report_id: maintenance_report_id) }
  scope :creation_date, ->(creation_date) { where(creation_date: creation_date) }
  scope :estimated_cost, ->(estimated_cost) { where(estimated_cost: estimated_cost) }
end

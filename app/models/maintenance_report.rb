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
class MaintenanceReport < ApplicationRecord
  audited
  belongs_to :vehicle
  has_many :service_orders

  # Validations
  validates :description, :vehicle_id, :report_date, :priority, :status, presence: true

  # Enum Status
  enum :status, { pending: 0, processed: 1, refused: 2 }, default: :pending

  # Enum Priority
  enum :priority, { high: 0, medium: 1, low: 2 }, default: :high

  after_save :create_service_order, if: :high_priority?

  private

  def high_priority?
    high? && saved_change_to_priority?(to: :high)
  end

  def create_service_order
    ActiveRecord::Base.transaction do
      vehicle.update!(status: :in_maintenance)
      service_orders.create!(
        status: :open,
        creation_date: Time.current.to_date,
        estimated_cost: 0.0,
        vehicle: vehicle
      )
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Error processing service order: #{e.message}"
    raise e
  end
end

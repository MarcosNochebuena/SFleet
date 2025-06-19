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
  pending "add some examples to (or delete) #{__FILE__}"
end

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
FactoryBot.define do
  factory :maintenance_report do
    vehicle { FactoryBot.create(:vehicle) }
    description { "MyString" }
    report_date { "2025-06-18" }
    priority { 1 }
    status { 1 }
  end
end

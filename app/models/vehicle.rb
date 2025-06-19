# == Schema Information
#
# Table name: vehicles
#
#  id            :bigint           not null, primary key
#  license_plate :string
#  make          :string
#  model         :string
#  status        :integer
#  year          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Vehicle < ApplicationRecord
  audited
  has_many :maintenance_reports
  has_many :service_orders

  #  Validations
  validates :license_plate, presence: true, uniqueness: true
  validates :make, :model, :year, presence: true

  #  Enum Status
  enum :status, { available: 0, in_service: 1, in_maintenance: 2, out_of_service: 3 }, default: :available
end

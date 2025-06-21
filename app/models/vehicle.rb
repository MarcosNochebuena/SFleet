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
  validates :make, :model, :status, :year, presence: true
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: Date.today.year }
  validates :license_plate, format: { with: /\A[A-Z0-9]{6,8}\z/, message: "must be 6-8 alphanumeric characters" }
  validates :make, format: { with: /\A[A-Za-z]{3,}\z/, message: "must be 3-8 letters or numbers" }
  validates :model, format: { with: /\A[A-Za-z0-9]{2,8}\z/, message: "must be 2-8 letters or numbers" }

  #  Enum Status
  enum :status, { available: 0, in_service: 1, in_maintenance: 2, out_of_service: 3 }, default: :available

  # Scopes
  scope :status, ->(status) { where(status: status) }
  scope :license_plate, ->(license_plate) { where(license_plate: license_plate) }
  scope :make, ->(make) { where(make: make) }
  scope :by_model, ->(model) { where(model: model) }
  scope :year, ->(year) { where(year: year) }
end

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

FactoryBot.define do
  factory :vehicle do
    sequence(:license_plate) { |n| "ABC#{100 + n}" }
    sequence(:make) { |n| "Make#{n}" }
    sequence(:model) { |n| "Model#{n}" }
    year { 2022 }
    status { :available }
  end
end

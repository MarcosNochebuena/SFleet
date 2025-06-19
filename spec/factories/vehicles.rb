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
    license_plate { "MyString" }
    make { "MyString" }
    model { "MyString" }
    year { 1 }
    status { 1 }
  end
end

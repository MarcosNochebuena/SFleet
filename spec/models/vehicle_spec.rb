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

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:vehicle)).to be_valid
  end
end

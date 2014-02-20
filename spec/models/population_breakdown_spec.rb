# == Schema Information
#
# Table name: population_breakdowns
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  women      :float
#  msm        :float
#  under_26   :float
#  black      :float
#  hispanic   :float
#  clinic_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe PopulationBreakdown do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:clinic) }
  it { should belong_to(:clinic) }

  [:women, :msm, :under_26, :black, :hispanic].each do |attr|
    it { should validate_presence_of(attr) }
    it { should validate_numericality_of(attr) }
  end
end

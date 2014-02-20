# == Schema Information
#
# Table name: epi_breakdowns
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  clinic_id  :integer
#  test_ct    :float
#  diag_ct    :float
#  test_gc    :float
#  diag_gc    :float
#  test_trich :float
#  diag_trich :float
#  test_hiv   :float
#  diag_hiv   :float
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe EpiBreakdown do
  it { should belong_to(:clinic) }

  it { should validate_numericality_of(:test_ct) }
  it { should validate_numericality_of(:diag_ct) }
  it { should validate_numericality_of(:test_gc) }
  it { should validate_numericality_of(:diag_gc) }
  it { should validate_numericality_of(:test_trich) }
  it { should validate_numericality_of(:diag_trich) }
  it { should validate_numericality_of(:test_hiv) }
  it { should validate_numericality_of(:diag_hiv) }

  context 'given valid attributes' do
    subject { FactoryGirl.build(:epi_breakdown) }
    it { should be_valid }
  end
end

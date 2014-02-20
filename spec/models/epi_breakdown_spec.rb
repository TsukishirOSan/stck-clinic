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

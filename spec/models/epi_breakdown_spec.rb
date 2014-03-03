# == Schema Information
#
# Table name: epi_breakdowns
#
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string(255)</tt>
# *clinic_id*::  <tt>integer</tt>
# *test_ct*::    <tt>float</tt>
# *diag_ct*::    <tt>float</tt>
# *test_gc*::    <tt>float</tt>
# *diag_gc*::    <tt>float</tt>
# *test_trich*:: <tt>float</tt>
# *diag_trich*:: <tt>float</tt>
# *test_hiv*::   <tt>float</tt>
# *diag_hiv*::   <tt>float</tt>
# *created_at*:: <tt>datetime</tt>
# *updated_at*:: <tt>datetime</tt>
#--
# == Schema Information End
#++

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

# == Schema Information
#
# Table name: population_breakdowns
#
# *black*::      <tt>float</tt>
# *clinic_id*::  <tt>integer</tt>
# *created_at*:: <tt>datetime</tt>
# *hispanic*::   <tt>float</tt>
# *id*::         <tt>integer, not null, primary key</tt>
# *msm*::        <tt>float</tt>
# *name*::       <tt>string(255)</tt>
# *under_26*::   <tt>float</tt>
# *updated_at*:: <tt>datetime</tt>
# *women*::      <tt>float</tt>
#--
# == Schema Information End
#++

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

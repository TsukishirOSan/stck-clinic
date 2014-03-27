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

class PopulationBreakdown < ActiveRecord::Base
  has_paper_trail

  belongs_to :clinic

  validates :name, presence: true
  validates :clinic, presence: true

  [:women, :msm, :under_26, :black, :hispanic].each do |column_name|
    validates column_name, presence: true, numericality: true, allow_nil: true
  end
end

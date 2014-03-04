# == Schema Information
#
# Table name: population_breakdowns
#
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string(255)</tt>
# *women*::      <tt>float</tt>
# *msm*::        <tt>float</tt>
# *under_26*::   <tt>float</tt>
# *black*::      <tt>float</tt>
# *hispanic*::   <tt>float</tt>
# *clinic_id*::  <tt>integer</tt>
# *created_at*:: <tt>datetime</tt>
# *updated_at*:: <tt>datetime</tt>
#--
# == Schema Information End
#++

class PopulationBreakdown < ActiveRecord::Base
  belongs_to :clinic

  validates :name, presence: true
  validates :clinic, presence: true

  [:women, :msm, :under_26, :black, :hispanic].each do |column_name|
    validates column_name, presence: true, numericality: true
  end
end

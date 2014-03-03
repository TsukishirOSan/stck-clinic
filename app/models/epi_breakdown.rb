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

# The EpiBreakdown model holds a clinic's data concerning STD
# testing/diagnosis rates.
class EpiBreakdown < ActiveRecord::Base
  belongs_to :clinic

  [:test_ct,    :diag_ct,
   :test_gc,    :diag_gc,
   :test_trich, :diag_trich,
   :test_hiv,   :diag_hiv].each do |column_name|
    validates column_name, numericality: true
  end
end

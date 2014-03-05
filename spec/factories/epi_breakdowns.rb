# == Schema Information
#
# Table name: epi_breakdowns
#
# *clinic_id*::  <tt>integer</tt>
# *created_at*:: <tt>datetime</tt>
# *diag_ct*::    <tt>float</tt>
# *diag_gc*::    <tt>float</tt>
# *diag_hiv*::   <tt>float</tt>
# *diag_trich*:: <tt>float</tt>
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string(255)</tt>
# *test_ct*::    <tt>float</tt>
# *test_gc*::    <tt>float</tt>
# *test_hiv*::   <tt>float</tt>
# *test_trich*:: <tt>float</tt>
# *updated_at*:: <tt>datetime</tt>
#--
# == Schema Information End
#++

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :epi_breakdown do
    sequence(:name) {|n| "EpiBreakdown #{n}" }
    sequence(:test_ct) {|n| n + 1.5 }
    sequence(:diag_ct) {|n| n + 1.5 }
    sequence(:test_gc) {|n| n + 1.5 }
    sequence(:diag_gc) {|n| n + 1.5 }
    sequence(:test_trich) {|n| n + 1.5 }
    sequence(:diag_trich) {|n| n + 1.5 }
    sequence(:test_hiv) {|n| n + 1.5 }
    sequence(:diag_hiv) {|n| n + 1.5 }

    clinic
  end
end

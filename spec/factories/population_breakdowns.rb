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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :population_breakdown do
    name "MyString"
    sequence(:women) {|n| n + 1.5 }
    sequence(:msm) {|n| n + 1.5 }
    sequence(:under_26) {|n| n + 1.5 }
    sequence(:black) {|n| n + 1.5 }
    sequence(:hispanic) {|n| n + 1.5 }

    clinic
  end
end

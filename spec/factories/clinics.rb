# == Schema Information
#
# Table name: clinics
#
# *city*::                     <tt>string(255)</tt>
# *created_at*::               <tt>datetime</tt>
# *id*::                       <tt>integer, not null, primary key</tt>
# *name*::                     <tt>string(255)</tt>
# *notes*::                    <tt>text</tt>
# *state*::                    <tt>string(255)</tt>
# *street_address*::           <tt>string(255)</tt>
# *street_address_continued*:: <tt>string(255)</tt>
# *updated_at*::               <tt>datetime</tt>
# *zip*::                      <tt>string(255)</tt>
#--
# == Schema Information End
#++

FactoryGirl.define do
  factory :clinic do
    sequence(:city) {|n| "Clinic city #{n}" }
    sequence(:name) {|n| "Clinic name #{n}" }
    sequence(:state) {|n| "Clinic state #{n}" }
    sequence(:street_address) {|n| "Clinic street address #{n}" }
    sequence(:street_address_continued) {|n| "Clinic street address continued #{n}" }
    sequence(:zip) {|n| "Clinic zip #{n}" }
  end
end

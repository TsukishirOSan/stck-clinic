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

    after(:build) do |clinic, evaluator|
      clinic.contact = FactoryGirl.build(:contact, clinic: clinic)
      clinic.epi_breakdown = FactoryGirl.build(:epi_breakdown, clinic: clinic)
      clinic.population_breakdown = FactoryGirl.build(:population_breakdown, clinic: clinic)
      clinic.service_offering_description = FactoryGirl.build(:service_offering_description, clinic: clinic)
    end

    after(:create) do |clinic, evaluator|
      create_list(:order, 5, clinic: clinic)
    end
  end
end

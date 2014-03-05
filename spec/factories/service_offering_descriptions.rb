# == Schema Information
#
# Table name: service_offering_descriptions
#
# *charge_ct*::                          <tt>string(255)</tt>
# *clinic_id*::                          <tt>integer</tt>
# *college_health*::                     <tt>boolean</tt>
# *community_health*::                   <tt>boolean</tt>
# *created_at*::                         <tt>datetime</tt>
# *deliver_results_in_person*::          <tt>boolean</tt>
# *deliver_results_on_phone_automated*:: <tt>boolean</tt>
# *deliver_results_on_phone_human*::     <tt>boolean</tt>
# *deliver_results_online*::             <tt>boolean</tt>
# *deliver_results_other*::              <tt>boolean</tt>
# *family_planning*::                    <tt>boolean</tt>
# *id*::                                 <tt>integer, not null, primary key</tt>
# *name*::                               <tt>string(255)</tt>
# *notify_test_ready*::                  <tt>string(255)</tt>
# *other*::                              <tt>boolean</tt>
# *planned_parenthood*::                 <tt>boolean</tt>
# *private_practice*::                   <tt>boolean</tt>
# *std*::                                <tt>boolean</tt>
# *updated_at*::                         <tt>datetime</tt>
#--
# == Schema Information End
#++

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service_offering_description do
    sequence(:name) {|n| "Service offering description #{n}" }

    college_health false
    community_health false
    family_planning false
    planned_parenthood false
    private_practice false
    std true
    other false

    charge_ct { ServiceOfferingDescription::CHARGE_CT_OPTIONS.first }
    notify_test_ready { ServiceOfferingDescription::NOTIFY_TEST_READY_OPTIONS.first }

    deliver_results_in_person true
    deliver_results_on_phone_automated true
    deliver_results_on_phone_human true
    deliver_results_online true
    deliver_results_other true

    clinic
  end
end

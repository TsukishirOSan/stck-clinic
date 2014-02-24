# == Schema Information
#
# Table name: service_offering_descriptions
#
#  id                                 :integer          not null, primary key
#  name                               :string(255)
#  clinic_id                          :integer
#  college_health                     :boolean
#  community_health                   :boolean
#  family_planning                    :boolean
#  planned_parenthood                 :boolean
#  private_practice                   :boolean
#  std                                :boolean
#  other                              :boolean
#  created_at                         :datetime
#  updated_at                         :datetime
#  charge_ct                          :string(255)
#  notify_test_ready                  :string(255)
#  deliver_results_online             :boolean
#  deliver_results_in_person          :boolean
#  deliver_results_on_phone_human     :boolean
#  deliver_results_on_phone_automated :boolean
#  deliver_results_other              :boolean
#

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

    clinic
  end
end

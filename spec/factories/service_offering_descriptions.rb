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

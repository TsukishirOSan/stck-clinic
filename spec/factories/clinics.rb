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

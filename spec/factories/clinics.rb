# == Schema Information
#
# Table name: clinics
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  street_address           :string(255)
#  city                     :string(255)
#  state                    :string(255)
#  zip                      :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  street_address_continued :string(255)
#  notes                    :text
#

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

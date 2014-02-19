# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  phone      :string(255)
#  email      :string(255)
#  notes      :text
#  clinic_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    sequence(:email) {|n| "contact.email#{n}@example.com" }
    sequence(:name)  {|n| "Contact name #{n}" }
    sequence(:notes) {|n| "Contact notes #{n}" }
    sequence(:phone) {|n| "212-555-999#{n}" }
    sequence(:title) {|n| "Contact title #{n}" }

    clinic
  end
end

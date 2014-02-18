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

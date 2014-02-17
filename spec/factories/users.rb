FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "User #{n}" }
    sequence(:email) {|n| "user.email.#{n}@example.com" }
    password 'SomeSortOfPassword'
    password_confirmation 'SomeSortOfPassword'
    admin false
  end
end

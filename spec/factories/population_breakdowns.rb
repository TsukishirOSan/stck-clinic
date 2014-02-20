# == Schema Information
#
# Table name: population_breakdowns
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  women      :float
#  msm        :float
#  under_26   :float
#  black      :float
#  hispanic   :float
#  clinic_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :population_breakdown do
    name "MyString"
    sequence(:women) {|n| n + 1.5 }
    sequence(:msm) {|n| n + 1.5 }
    sequence(:under_26) {|n| n + 1.5 }
    sequence(:black) {|n| n + 1.5 }
    sequence(:hispanic) {|n| n + 1.5 }

    clinic
  end
end

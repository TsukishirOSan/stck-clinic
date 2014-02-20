# == Schema Information
#
# Table name: epi_breakdowns
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  clinic_id  :integer
#  test_ct    :float
#  diag_ct    :float
#  test_gc    :float
#  diag_gc    :float
#  test_trich :float
#  diag_trich :float
#  test_hiv   :float
#  diag_hiv   :float
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :epi_breakdown do
    sequence(:name) {|n| "EpiBreakdown #{n}" }
    sequence(:test_ct) {|n| n + 1.5 }
    sequence(:diag_ct) {|n| n + 1.5 }
    sequence(:test_gc) {|n| n + 1.5 }
    sequence(:diag_gc) {|n| n + 1.5 }
    sequence(:test_trich) {|n| n + 1.5 }
    sequence(:diag_trich) {|n| n + 1.5 }
    sequence(:test_hiv) {|n| n + 1.5 }
    sequence(:diag_hiv) {|n| n + 1.5 }

    clinic
  end
end

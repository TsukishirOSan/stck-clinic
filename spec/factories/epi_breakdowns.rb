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

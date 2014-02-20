class EpiBreakdown < ActiveRecord::Base
  belongs_to :clinic

  [:test_ct,    :diag_ct,
   :test_gc,    :diag_gc,
   :test_trich, :diag_trich,
   :test_hiv,   :diag_hiv].each do |column_name|
    validates column_name, numericality: true
  end
end

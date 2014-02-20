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

class EpiBreakdown < ActiveRecord::Base
  belongs_to :clinic

  [:test_ct,    :diag_ct,
   :test_gc,    :diag_gc,
   :test_trich, :diag_trich,
   :test_hiv,   :diag_hiv].each do |column_name|
    validates column_name, numericality: true
  end
end

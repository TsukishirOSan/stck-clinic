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

class PopulationBreakdown < ActiveRecord::Base
  belongs_to :clinic

  validates :name, presence: true
  validates :clinic, presence: true

  [:women, :msm, :under_26, :black, :hispanic].each do |column_name|
    validates column_name, presence: true, numericality: true
  end
end

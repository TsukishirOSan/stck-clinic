class PopulationBreakdown < ActiveRecord::Base
  belongs_to :clinic

  validates :name, presence: true
  validates :clinic, presence: true

  [:women, :msm, :under_26, :black, :hispanic].each do |column_name|
    validates column_name, presence: true, numericality: true
  end
end

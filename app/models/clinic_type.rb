class ClinicType < ActiveRecord::Base
  validates :name, presence: true
end

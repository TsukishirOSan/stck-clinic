class Clinic < ActiveRecord::Base
  validates :name, presence: true
  # basic info
  validates :city, presence: true
  validates :state, presence: true
  validates :street_address, presence: true
  validates :zip, presence: true

  has_one :contact
end

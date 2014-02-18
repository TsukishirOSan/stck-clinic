class Clinic < ActiveRecord::Base
  # basic info
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :street_address, presence: true
  validates :zip, presence: true

  has_one :contact
end

class Clinic < ActiveRecord::Base
  validates :name, presence: true
  # basic info
  validates :city, presence: true
  validates :state, presence: true
  validates :street_address, presence: true
  validates :zip, presence: true
  # contact info
  validates :contact_email, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, presence: true
  validates :contact_title, presence: true
end

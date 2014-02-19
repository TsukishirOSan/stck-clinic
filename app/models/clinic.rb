# == Schema Information
#
# Table name: clinics
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  street_address           :string(255)
#  city                     :string(255)
#  state                    :string(255)
#  zip                      :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  street_address_continued :string(255)
#  notes                    :text
#

class Clinic < ActiveRecord::Base
  # basic info
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :street_address, presence: true
  validates :zip, presence: true

  has_one :contact
  has_one :service_offering_description
end

# == Schema Information
#
# Table name: clinics
#
# *city*::                     <tt>string(255)</tt>
# *created_at*::               <tt>datetime</tt>
# *id*::                       <tt>integer, not null, primary key</tt>
# *name*::                     <tt>string(255)</tt>
# *notes*::                    <tt>text</tt>
# *state*::                    <tt>string(255)</tt>
# *street_address*::           <tt>string(255)</tt>
# *street_address_continued*:: <tt>string(255)</tt>
# *updated_at*::               <tt>datetime</tt>
# *zip*::                      <tt>string(255)</tt>
#--
# == Schema Information End
#++

class Clinic < ActiveRecord::Base
  has_paper_trail
  include Contracts

  # basic info
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :street_address, presence: true
  validates :zip, presence: true

  has_one :contact, dependent: :destroy
  has_one :population_breakdown, dependent: :destroy
  has_one :service_offering_description, dependent: :destroy
  has_one :epi_breakdown, dependent: :destroy
  has_many :orders, dependent: :destroy

  EMAIL_NOTIFICATION_METHOD = :new_clinic_email
  include EmailNotificationDelivery
end

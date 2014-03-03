# == Schema Information
#
# Table name: clinics
#
# *id*::                       <tt>integer, not null, primary key</tt>
# *name*::                     <tt>string(255)</tt>
# *street_address*::           <tt>string(255)</tt>
# *city*::                     <tt>string(255)</tt>
# *state*::                    <tt>string(255)</tt>
# *zip*::                      <tt>string(255)</tt>
# *created_at*::               <tt>datetime</tt>
# *updated_at*::               <tt>datetime</tt>
# *street_address_continued*:: <tt>string(255)</tt>
# *notes*::                    <tt>text</tt>
#--
# == Schema Information End
#++

# Top-level entity on the domain model which holds all the other stuff
# together. Core notion of a clinic.
class Clinic < ActiveRecord::Base
  # basic info
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :street_address, presence: true
  validates :zip, presence: true

  has_one :contact
  has_one :population_breakdown
  has_one :service_offering_description
  has_one :epi_breakdown
end

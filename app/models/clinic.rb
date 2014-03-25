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

  has_one :contact
  has_one :population_breakdown
  has_one :service_offering_description
  has_one :epi_breakdown
  has_many :orders

  after_create :send_notification_email

  private
  Contract nil => Maybe[Bool]
  # handle sending notification upon new clinic creation
  # @api private
  # @return [true,false] success of sending notification email
  def send_notification_email
    if ClinicMailer.new_clinic_email(self).deliver
      Rails.logger.info("Sent #{Clinic.model_name.human} notification for #{self.id}")
      true
    else
      Rails.logger.info("Couldn't send #{Clinic.model_name.human} notification for #{self.id}")
      false
    end
  end
end

# == Schema Information
#
# Table name: service_offering_descriptions
#
# *id*::                                 <tt>integer, not null, primary key</tt>
# *name*::                               <tt>string(255)</tt>
# *clinic_id*::                          <tt>integer</tt>
# *college_health*::                     <tt>boolean</tt>
# *community_health*::                   <tt>boolean</tt>
# *family_planning*::                    <tt>boolean</tt>
# *planned_parenthood*::                 <tt>boolean</tt>
# *private_practice*::                   <tt>boolean</tt>
# *std*::                                <tt>boolean</tt>
# *other*::                              <tt>boolean</tt>
# *created_at*::                         <tt>datetime</tt>
# *updated_at*::                         <tt>datetime</tt>
# *charge_ct*::                          <tt>string(255)</tt>
# *notify_test_ready*::                  <tt>string(255)</tt>
# *deliver_results_online*::             <tt>boolean</tt>
# *deliver_results_in_person*::          <tt>boolean</tt>
# *deliver_results_on_phone_human*::     <tt>boolean</tt>
# *deliver_results_on_phone_automated*:: <tt>boolean</tt>
# *deliver_results_other*::              <tt>boolean</tt>
#--
# == Schema Information End
#++

class ServiceOfferingDescription < ActiveRecord::Base
  include Contracts
  belongs_to :clinic

  validates :name, presence: true
  validates :clinic, presence: true

  include EnsureOneService

  # options for CT charge type
  # @return [Array<String>]
  CHARGE_CT_OPTIONS = ["Free", "Depends on the insurance", "Sliding scale", "Flat fee", "Other"]
  validates :charge_ct, inclusion: {in: CHARGE_CT_OPTIONS}, allow_nil: true

  # options for notify test ready
  # @return [Array<String>]
  NOTIFY_TEST_READY_OPTIONS = ["No", "Yes, for people who are positive", "Yes, for all patients", "Other"]
  validates :notify_test_ready, inclusion: {in: NOTIFY_TEST_READY_OPTIONS}, allow_nil: true

  Contract nil => ArrayOf[String]
  # @return [Array<String>] charge ct options to RailsAdmin smart enum
  def charge_ct_enum
    CHARGE_CT_OPTIONS
  end

  Contract nil => ArrayOf[String]
  # @return [Array<String>] notify test ready options to RailsAdmin smart enum
  def notify_test_ready_enum
    NOTIFY_TEST_READY_OPTIONS
  end
end

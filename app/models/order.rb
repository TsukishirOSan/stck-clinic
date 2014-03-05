# == Schema Information
#
# Table name: orders
#
# *brochure_quantity*:: <tt>integer</tt>
# *card_quantity*::     <tt>integer</tt>
# *clinic_code*::       <tt>string(255)</tt>
# *clinic_id*::         <tt>integer</tt>
# *created_at*::        <tt>datetime</tt>
# *envelope_cost*::     <tt>float</tt>
# *id*::                <tt>integer, not null, primary key</tt>
# *name*::              <tt>string(255)</tt>
# *notes*::             <tt>text</tt>
# *order_type*::        <tt>string(255)</tt>
# *postage_cost*::      <tt>float</tt>
# *sent_on*::           <tt>date</tt>
# *status*::            <tt>string(255)</tt>
# *updated_at*::        <tt>datetime</tt>
# *use*::               <tt>string(255)</tt>
#--
# == Schema Information End
#++

class Order < ActiveRecord::Base
  include Contracts

  belongs_to :clinic

  validates :card_quantity, presence: true, numericality: true
  validates :brochure_quantity, presence: true, numericality: true

  # @return [Array<String>]
  TYPE_OPTIONS = [ 'Mixed', 'All Color', 'All BW' ]
  validates :order_type, presence: true, inclusion: { in: TYPE_OPTIONS }

  # @return [Array<String>]
  USE_OPTIONS = [ 'Educational', 'Promotional', 'Other' ]
  validates :use, presence: true, inclusion: { in: USE_OPTIONS }

  # @return [Array<String>]
  STATUS_OPTIONS = [ 'Unsent', 'Sent' ]
  validates :status, presence: true, inclusion: { in: STATUS_OPTIONS }

  before_validation :maybe_set_name, on: :create
  before_validation :set_status_if_sent#, on: :save

  Contract nil => ArrayOf[String]
  # @return [Array<String>] use options for RailsAdmin
  def use_enum
    USE_OPTIONS
  end

  Contract nil => ArrayOf[String]
  # @return [Array<String>] type options for RailsAdmin
  def order_type_enum
    TYPE_OPTIONS
  end

  Contract nil => ArrayOf[String]
  def status_enum
    STATUS_OPTIONS
  end

  private
  Contract nil => String
  def maybe_set_name
    if name.present?
      name
    else
      self.name = "#{Order.model_name.human} for #{Clinic.model_name.human} on #{Date.today}"
    end
  end

  Contract nil => Or[String, nil]
  def set_status_if_sent
    if sent_on.present?
      self.status = 'Sent'
    else
      self.status = 'Unsent' if self.persisted?
    end

    self.status
  end
end

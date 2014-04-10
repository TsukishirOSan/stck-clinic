# Orchestrates entire Order import process by delegating to the
# appropriate components
# @api public
class OrderCsvImporter < Struct.new(:path)
  include Contracts
  include ImporterComponents

  Contract Hash => Any
  # contains business logic for creating Order objects
  # @api private
  # @return [?] a new Order
  def process_row_hash(row_attributes)
    Rails.logger.info("Processing row hash for #{Rainbow(row_attributes[:clinic_name]).blue}")
    clinic_name = row_attributes['Clinic']
    clinic = Clinic.where(name: clinic_name).first

    if clinic.present?
      name = order_name(clinic_name,
                        row_attributes.fetch('Order type'),
                        row_attributes.fetch('Use'),
                        row_attributes.fetch('Sent on'))
      attributes = attributes_hash(name, row_attributes)
      clinic.orders.create(attributes)
    else
      fail "Couldn't find a clinic called #{clinic_name}"
    end
  end

  Contract String, String, String, String => String
  def order_name(clinic_name, date, type, use)
    "#{clinic_name} #{Order.model_name.human} (#{type} #{use}) on #{date}"
  end

  Contract String, Hash => Hash
  def attributes_hash(name, row_attributes)
    {
      :name => name,
      :card_quantity => row_attributes.fetch('Card Quantity'),
      :brochure_quantity => row_attributes.fetch('Brochure quantity'),
      :sent_on => Date.parse(row_attributes.fetch('Sent on')),
      :envelope_cost => row_attributes.fetch('Envelope cost'),
      :postage_cost => row_attributes.fetch('Postage cost'),
      :use => row_attributes.fetch('Use'),
      :order_type => row_attributes.fetch('Order type'),
      :notes => row_attributes.fetch('Notes'),
      :clinic_code => row_attributes.fetch('Clinic Code', nil)
    }
  end
end

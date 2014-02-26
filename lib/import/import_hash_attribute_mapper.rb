class ImportHashAttributeMapper < Struct.new(:import_hash)
  include Contracts

  ATTRIBUTE_MAP_TABLE = {
    # Clinic info
    "Clinic name" => :clinic_name,
    "Address line 1" => :clinic_street_address,
    "Address line 2" => :clinic_street_address_continued,
    "City" => :clinic_city,
    "State" => :clinic_state,
    "Zip code" => :clinic_zip,
    # Contact info
    "Main contact name" => :contact_name,
    "Phone number" => :contact_phone,
    "Main contact email" => :contact_email,
    "Title" => :contact_title,
    # charges info
    "Do you notify clients when their test results are ready?" => :notify_test_ready,
    "How much do you charge clients for a chlamydia test?" => :charge_ct
  }

  def mapped_attribute_hash
    attribute_hash_mapped_by_table
  end

  def attribute_hash_mapped_by_table
    pairs = ATTRIBUTE_MAP_TABLE.map do |src, dest|
      Rails.logger.tagged("ImportHashAttributeMapper") do
        Rails.logger.info("Mapping '#{src}' -> '#{dest}'")
      end

      [dest, import_hash[src]]
    end

    Hash[pairs]
  end

  Contract Or[String, Num, nil] => Float
  def value_to_float(raw_value)
    value = raw_value.to_s.strip
    value.to_f
  end
end

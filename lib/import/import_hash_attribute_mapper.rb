class ImportHashAttributeMapper < Struct.new(:import_hash)
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
    "Title" => :contact_title
  }

  def mapped_attribute_hash
    pairs = ATTRIBUTE_MAP_TABLE.map do |src, dest|
      Rails.logger.tagged("ImportHashAttributeMapper") do
        Rails.logger.info("Mapping '#{src}' -> '#{dest}'")
      end

      [dest, import_hash[src]]
    end

    Hash[pairs]
  end
end

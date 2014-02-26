class ImportHashAttributeMapper < Struct.new(:import_hash)
  include Contracts

  DIRECT_ATTRIBUTE_MAP_TABLE = {
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

  NUMERIC_ATTRIBUTE_MAP_TABLE = {
    "What percent of your clients are women?" => :population_women,
    "What percent of your clients are men who have sex with men (MSM)?" => :population_msm,
    "What percent of your clients are under 26?" => :population_under_26,
    "What percent of your clients are black/African American?" => :population_black,
    "What percent of your clients are hispanic/Latino(a)?" => :population_hispanic
  }

  def mapped_attribute_hash
    [
      mapped_direct_attribute_hash,
      mapped_numeric_attribute_hash
    ].reduce(&:merge)
  end

  def mapped_direct_attribute_hash
    pairs = DIRECT_ATTRIBUTE_MAP_TABLE.map do |src, dest|
      Rails.logger.info("Mapping directly '#{src}' -> '#{dest}'")
      [dest, import_hash[src]]
    end

    Hash[pairs]
  end

  def mapped_numeric_attribute_hash
    pairs = NUMERIC_ATTRIBUTE_MAP_TABLE.map do |src, dest|
      Rails.logger.info("Mapping numeric '#{src}' -> '#{dest}'")
      [ dest, value_to_float(import_hash[src]) ]
    end

    Hash[pairs]
  end

  Contract Or[String, Num, nil] => Float
  def value_to_float(raw_value)
    value = raw_value.to_s.strip
    value.to_f
  end
end

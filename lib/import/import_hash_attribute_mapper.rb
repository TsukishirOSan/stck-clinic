# Maps hash constructed from CSV to hash suitable for passing to
# some Clinic factory.
class ImportHashAttributeMapper < Struct.new(:import_hash)
  include Contracts

  # Data we can map directly, which require no processing
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

  # Data we can map after processing with numeric filter
  NUMERIC_ATTRIBUTE_MAP_TABLE = {
    "What percent of your clients are women?" => :population_women,
    "What percent of your clients are men who have sex with men (MSM)?" => :population_msm,
    "What percent of your clients are under 26?" => :population_under_26,
    "What percent of your clients are black/African American?" => :population_black,
    "What percent of your clients are hispanic/Latino(a)?" => :population_hispanic,
    "How many people did you test last year for chlamydia?" => :test_ct,
    "How many did you diagnose with chlamydia?" => :diag_ct,
    "How many did you test for gonorrhea?" => :test_gc,
    "How many did you diagnose with gonorrhea?" => :diag_gc,
    "How many did you test for trichomoniasis?" => :test_trich,
    "How may did you diagnose with trichomoniasis?" => :diag_trich,
    "How many did you test for HIV?" => :test_hiv,
    "How many did you diagnose with HIV?" => :diag_hiv,
  }

  Contract nil => Hash
  # Constructs properly-mapped attribute hash.
  # @return [Array<Hash {Symbol => String,Float}>] mapped attribute hash with symbol keys.
  def mapped_attribute_hash
    [
      mapped_direct_attribute_hash,
      mapped_numeric_attribute_hash
    ].reduce(&:merge)
  end

  Contract nil => Hash
  # Directly maps attributes.
  # @return [Array<Hash {Symbol => String,Float}>] directly-mapped attribute hash.
  def mapped_direct_attribute_hash
    pairs = DIRECT_ATTRIBUTE_MAP_TABLE.map do |src, dest|
      Rails.logger.info("Mapping directly '#{src}' -> '#{dest}'")
      [dest, import_hash[src]]
    end

    Hash[pairs]
  end

  Contract nil => Hash
  # Processes numeric fields and maps them.
  # @return [Array<Hash {Symbol => String,Float}>] numerically-mapped attribute hash.
  def mapped_numeric_attribute_hash
    pairs = NUMERIC_ATTRIBUTE_MAP_TABLE.map do |src, dest|
      Rails.logger.info("Mapping numeric '#{src}' -> '#{dest}'")
      [ dest, value_to_float(import_hash[src]) ]
    end

    Hash[pairs]
  end

  Contract Or[String, Num, nil] => Float
  # Sensibly convert string value to float
  # @param raw_value [String,Numeric] some column value
  # @return [Float] converted value
  def value_to_float(raw_value)
    value = raw_value.to_s.strip
    value.to_f
  end
end

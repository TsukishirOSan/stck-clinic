# Maps hash constructed from CSV to hash suitable for passing to
# some Clinic factory.
# @api semipublic
class ImportHashAttributeMapper < Struct.new(:import_hash)
  include Contracts

  Contract nil => HashOf[String,Symbol]
  # Data we can map directly, which require no processing
  # @api private
  # @return [Hash<String, Symbol>] DIRECT_ATTRIBUTE_MAP_TABLE
  DIRECT_ATTRIBUTE_MAP_TABLE = {
    # Clinic info
    'Clinic name'                                              => :clinic_name,
    'Address line 1'                                           => :clinic_street_address,
    'Address line 2'                                           => :clinic_street_address_continued,
    'City'                                                     => :clinic_city,
    'State'                                                    => :clinic_state,
    'Zip code'                                                 => :clinic_zip,
    # Contact info
    'Main contact name'                                        => :contact_name,
    'Phone number'                                             => :contact_phone,
    'Main contact email'                                       => :contact_email,
    'Title'                                                    => :contact_title,
    # charges info
    'Do you notify clients when their test results are ready?' => :notify_test_ready,
    'How much do you charge clients for a chlamydia test?'     => :charge_ct
  }

  Contract nil => Hash[String, Symbol]
  # Data we can map after processing with numeric filter
  # @api private
  # @return [Hash<String, Symbol>] NUMERIC_ATTRIBUTE_MAP_TABLE
  NUMERIC_ATTRIBUTE_MAP_TABLE = {
    'What percent of your clients are women?'                           => :population_women,
    'What percent of your clients are men who have sex with men (MSM)?' => :population_msm,
    'What percent of your clients are under 26?'                        => :population_under_26,
    'What percent of your clients are black/African American?'          => :population_black,
    'What percent of your clients are hispanic/Latino(a)?'              => :population_hispanic,
    'How many people did you test last year for chlamydia?'             => :test_ct,
    'How many did you diagnose with chlamydia?'                         => :diag_ct,
    'How many did you test for gonorrhea?'                              => :test_gc,
    'How many did you diagnose with gonorrhea?'                         => :diag_gc,
    'How many did you test for trichomoniasis?'                         => :test_trich,
    'How may did you diagnose with trichomoniasis?'                     => :diag_trich,
    'How many did you test for HIV?'                                    => :test_hiv,
    'How many did you diagnose with HIV?'                               => :diag_hiv
  }

  Contract nil => Hash
  # Showing how to map columns with multiple values
  # @api private
  # @return [Hash<String, Hash<String, Symbol>>] MULTI_VALUE_ATTRIBUTE_MAP_TABLE
  MULTI_VALUE_ATTRIBUTE_MAP_TABLE = {
    'Clinic type' => {
      'std clinic'                       => :std,
      'college health center'            => :college_health,
      'community health center'          => :community_health,
      'family planning clinic'           => :family_planning,
      'planned parenthood health center' => :planned_parenthood,
      'private practice'                 => :private_practice,
      'other'                            => :other
    },
    'How do you deliver chlamydia test results?' => {
      'online'                                                       => :deliver_results_online,
      'in person'                                                    => :deliver_results_in_person,
      'on the phone (with a human being answering/calling)'          => :deliver_results_on_phone_human,
      'on the phone (with an automated voice delivering the result)' => :deliver_results_on_phone_automated,
      'other'                                                        => :deliver_results_other
    }
  }

  Contract nil => HashOf[Symbol, Or[String, Float, nil]]
  # Constructs properly-mapped attribute hash
  # @api public
  # @return [Array<Hash {Symbol => String, Float, nil}>] mapped attribute hash with symbol keys.
  def mapped_attribute_hash
    [
      mapped_direct_attribute_hash,
      mapped_multi_value_hash,
      mapped_numeric_attribute_hash
    ].reduce(&:merge)
  end

  Contract nil => HashOf[Symbol, Bool]
  # Convert columns containing multiple values to their bool column equivalents
  # @api private
  # return [Hash] qwweew
  def mapped_multi_value_hash
    MULTI_VALUE_ATTRIBUTE_MAP_TABLE.map do |column_name, map|
      output = MultiValueColumnProcessor.new(import_hash.fetch(column_name, ''), map).values_hash

      output
    end.flatten.reduce(&:merge)
  end

  Contract nil => HashOf[Symbol, Or[String, Float, nil]]
  # Directly maps attributes
  # @api private
  # @return [Array<Hash {Symbol => String, Float}>] directly-mapped attribute hash
  def mapped_direct_attribute_hash
    pairs = DIRECT_ATTRIBUTE_MAP_TABLE.map do |src, dest|
      Rails.logger.info("Mapping directly '#{src}' -> '#{dest}'")

      [dest, import_hash.fetch(src, '').to_s]
    end

    Hash[pairs]
  end

  Contract nil => Hash
  # Processes numeric fields and maps them
  # @api private
  # @return [Array<Hash {Symbol => String,Float}>] numerically-mapped attribute hash
  def mapped_numeric_attribute_hash
    pairs = NUMERIC_ATTRIBUTE_MAP_TABLE.map do |src, dest|
      Rails.logger.info("Mapping numeric '#{src}' -> '#{dest}'")
      [
        dest,
        value_to_float(import_hash.fetch(src, 0))
      ]
    end

    Hash[pairs]
  end

  Contract Or[String, Num, nil] => Maybe[Float]
  # Sensibly convert string value to float
  # @api semipublic
  # @param raw_value [String,Numeric] some column value
  # @return [Float,nil] converted value
  def value_to_float(raw_value)
    value = raw_value.to_s.strip.chomp

    if '-' == value || '' == value
      output = nil
    else
      output = value.to_f
    end

    output
  end
end

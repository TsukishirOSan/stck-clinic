# Orchestrates entire Clinic import process by delegating to the
# appropriate components
# @api public
class CsvDataImporter < Struct.new(:path)
  include ImporterComponents
  include Contracts

  Contract Hash => Any
  # contains business logic for actually
  # @api private
  # @return [?] a new Clinic complete with associated object as filled
  #   in by CSV data source
  def process_row_hash(row_hash)
    row_attributes = transform_hash(row_hash)
    Rails.logger.info("Processing row hash for #{Rainbow(row_attributes[:clinic_name]).blue}")
    ClinicSignUpInteraction.run!(row_attributes)
  end

  Contract HashOf[String, Maybe[String]] => Hash[Symbol, Or[String, Bool, Num, nil]]
  # Transforms a hash from raw to saveable
  # @api private
  # @param [Hash{String=>String,nil}] row_hash contains raw-from-csv hash
  # @return [Hash{String=>String,Bool,Num,nil}]
  def transform_hash(row_hash)
    Rails.logger.info("Transforming hash for #{Rainbow(row_hash['Clinic name']).blue}")
    ImportHashAttributeMapper.new(row_hash).mapped_attribute_hash
  end
end

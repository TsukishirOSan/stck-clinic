# Orchestrates entire data import process by delegating to the
# appropriate components
# @api public
class CsvDataImporter < Struct.new(:path)
  include Contracts

  Contract nil => ArrayOf[Hash]
  # Returns the CSV's row data as hashes
  # @api private
  # @return [Array<Hash>] the array of rows expressed as hashes
  def row_hashes
    @row_hashes ||= DataCsvReader.new(path).to_hashes
  end

  Contract Hash => Any
  # contains business logic for actually
  # @api private
  # @return [?] a new Clinic complete with associated object as filled
  #   in by CSV data source
  def process_row_hash(row_hash)
  end

  Contract Hash => Hash # HashOf[String, Maybe[String]] => Hash[Symbol, Or[String, Bool, Num, nil]]
  # Transforms a hash from raw to saveable
  # @api private
  # @param [Hash{String=>String,nil}]
  # @return [Hash{String=>String,Bool,Num,nil}]
  def transform_hash(row_hash)
    ImportHashAttributeMapper.new(row_hash).mapped_attribute_hash
  end
end

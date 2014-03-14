require 'csv'

# Responsible for sensibly reading a CSV, constructing hashes from
# column data. Assumes headers for this purpose.
class DataCsvReader < Struct.new(:path)
  include Contracts

  Contract nil => ArrayOf[Array]
  # Data rows in the CSV, excluding help and info rows
  # @api private
  # @return [Array<Array<String>>] raw rows
  def rows
    @rows ||= CSV.read(path)
            .each_with_index
            .reject {|row, index| (1..3).include?(index) }
            .map(&:first)
  end

  Contract nil => ArrayOf[String]
  # Yields the header row, assumed the first row
  # @api private
  # @return [Array<String>] header row
  def headers
    @headers ||= rows.first
  end

  Contract nil => ArrayOf[Hash]
  # Constructs hashes with keys as header fields and values of column data
  # @api public
  # @example
  #  data_csv_reading.to_hashes #=> Array<Hash{String=>String,nil}>
  # @return [Array<Hash{String=>String,nil}>] an array of hashes
  def to_hashes
    rows[1..rows.length].map do |row|
      Hash[headers.zip(row)]
    end
  end
end

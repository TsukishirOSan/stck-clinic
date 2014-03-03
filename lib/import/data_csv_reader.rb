require 'csv'

# Responsible for sensibly reading a CSV, constructing hashes from
# column data. Assumes headers for this purpose.
class DataCsvReader < Struct.new(:path)
  include Contracts

  Contract nil => ArrayOf[Array]
  # Gives data-containing rows in the CSV, excluding help and info
  # rows present in spreadsheet.
  # @return [Array<Array<String>>] raw rows
  def rows
    @rows ||= CSV.read(path)
            .each_with_index
            .reject { |row, index| (1..5).include?(index) }
            .map(&:first)
  end

  Contract nil => ArrayOf[String]
  # Yields the header row, assumed the first row.
  # @return [Array<String>] header row
  def headers
    @headers ||= rows.first
  end

  Contract nil => ArrayOf[Hash]
  # Constructs hashes with keys as header fields and values as the
  # data in the corresponding column
  # @return [Array<Hash>] an array of hashes
  def to_hashes
    rows[1..rows.length].map do |row|
      Hash[headers.zip(row)]
    end
  end
end

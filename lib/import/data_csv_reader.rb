require 'csv'

# Responsible for sensibly reading a CSV, constructing hashes from
# column data. Assumes headers for this purpose.

class DataCsvReader < Struct.new(:path)
  include Contracts

  # Gives data-containing rows in the CSV, excluding help and info
  # rows present in spreadsheet.
  # @return [Array] raw rows
  Contract nil => ArrayOf[Array]
  def rows
    @rows ||= CSV.read(path)
            .each_with_index
            .reject { |row, index| (1..5).include?(index) }
            .map(&:first)
  end

  # Yields the header row, assumed the first row.
  # @return [Array] header row
  Contract nil => ArrayOf[String]
  def headers
    @headers ||= rows.first
  end

  # Constructs hashes with keys as header fields and values as the
  # data in the corresponding column
  # @return [Array] an array of hashes
  Contract nil => ArrayOf[Hash]
  def to_hashes
    rows[1..rows.length].map do |row|
      Hash[headers.zip(row)]
    end
  end
end

require 'csv'

class DataCsvReader < Struct.new(:path)
  def rows
    @rows ||= CSV.read(path)
            .each_with_index
            .reject { |row, index| (1..5).include?(index) }
            .map(&:first)
  end

  def headers
    @headers ||= rows.first
  end

  def to_hashes
    rows[1..rows.length].map do |row|
      Hash[headers.zip(row)]
    end
  end
end

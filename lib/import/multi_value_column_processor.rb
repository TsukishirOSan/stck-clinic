# Processes multi value columns containing comma-sep data
class MultiValueColumnProcessor < Struct.new(:raw_column_value, :transformation_map)
  include Contracts

  Contract nil => Hash
  # maps import column values to their model attribute equivalents
  # @raise [RuntimeError] if the column contains a value we don't know how to map
  # @return [Hash] the mapped attribute hash
  def values_hash
    column_values = preprocess_column(raw_column_value)

    # checking to make sure we know how to map everything
    column_values.each do |column_value|
      fail "Don't know how to map value #{column_value}!" unless transformation_map.has_key?(column_value)
    end

    # actually do the mapping
    transformation_map.map do |value, destination_attribute|
      {
        destination_attribute => column_values.include?(value)
      }
    end.reduce(&:merge)
  end

  Contract String => ArrayOf[String]
  # splits column on comma character and cleans up values
  # @param [String] raw_column the raw column
  # @return [Array<String>] the array of cleaned up string values
  def preprocess_column(raw_column)
    raw_column.split(',')
      .map(&:downcase)
      .map(&:strip)
  end
end

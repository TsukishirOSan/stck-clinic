# Processes multi value columns containing comma-sep data
class MultiValueColumnProcessor < Struct.new(:raw_column_value, :transformation_map)
  include Contracts

  Contract nil => HashOf[Symbol, Bool]
  # maps import column values to their model attribute equivalents
  # @raise [RuntimeError] if the column contains a value we don't know how to map
  # @api public
  # @example
  #   multi_value_column_processor.values_hash #=> [{...}, ...]
  # @return [Hash<Symbol, Bool>] the mapped attribute hash
  def values_hash
    column_values = preprocess_column(raw_column_value)

    # checking to make sure we know how to map everything
    column_values.each do |column_value|
      fail "Don't know how to map value #{Rainbow(column_value).red}!" unless transformation_map.has_key?(column_value)
    end

    # actually do the mapping
    transformation_map.map do |value, destination_attribute|
      {
        destination_attribute => column_values.include?(value)
      }
    end.reduce(&:merge)
  end

  Contract Maybe[String] => ArrayOf[String]
  # splits column on comma character and cleans up values
  # @param [String,nil] raw_column the raw column
  # @api public
  # @example
  #   multi_value_column_processor.preprocess_column("panda, bamboo, curry")
  # @return [Array<String>] the array of cleaned up string values
  def preprocess_column(raw_column)
    if '-' == raw_column || raw_column.nil?
      output = []
    else
      output = raw_column.split(',')
        .map(&:downcase)
        .map(&:strip)
    end

    output
  end
end

module ImporterComponents
  include Contracts

  # Contract nil => Array
  # Executes the actual import
  # @api public
  # @return [Array] results from the ClinicSignUpInteraction executions
  def import!
    Rails.logger.tagged('CsvDataImporter') do
      Rails.logger.info("Importing data from CSV #{path}")
      output = row_hashes.map {|row_hash| process_row_hash(row_hash) }
      Rails.logger.info("Finished importing data from CSV #{path}")

      output
    end
  end

  # Contract nil => ArrayOf[Hash]
  # Returns the CSV's row data as hashes
  # @api private
  # @return [Array<Hash>] the array of rows expressed as hashes
  def row_hashes
    @row_hashes ||= DataCsvReader.new(path).to_hashes
  end

end

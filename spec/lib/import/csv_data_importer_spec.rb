require 'spec_helper'

describe CsvDataImporter do
  let(:data_csv_path) { Rails.root.join('spec', 'data', 'demo_import_data.csv').to_s }
  let(:csv_data_importer) { CsvDataImporter.new(data_csv_path) }
  let(:sample_hash) { csv_data_importer.row_hashes.first }

  describe '#row_hashes' do
    it 'delegates to DataCsvReader' do
      expect(DataCsvReader).to receive(:new).and_call_original
      csv_data_importer.row_hashes
    end
  end

  describe '#transform_hash' do
    it 'delegates to ImportHashAttributeMapper' do
      expect(ImportHashAttributeMapper).to receive(:new).and_call_original
      csv_data_importer.transform_hash(sample_hash)
    end
  end

  describe '#process_row_hash' do
    it 'transforms the row' do
      expect(csv_data_importer).to receive(:transform_hash).with(sample_hash).and_call_original
      csv_data_importer.process_row_hash(sample_hash)
    end

    it 'delegates to ClinicSignUpInteraction' do
      expect(ClinicSignUpInteraction).to receive(:run!)
      csv_data_importer.process_row_hash(sample_hash)
    end
  end
end

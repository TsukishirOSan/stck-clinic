require 'spec_helper'

describe DataCsvReader do
  let(:data_csv_path) { Rails.root.join('spec', 'data', 'demo_import_data.csv').to_s }

  let(:data_csv_reader) { DataCsvReader.new(data_csv_path) }

  describe '#rows' do
    context 'returned rows length' do
      subject { data_csv_reader.rows.length }
      it { should == 6 }
    end
  end

  describe '#to_hashes' do
    let(:hashes) { data_csv_reader.to_hashes }

    context 'keys' do
      it 'should contain only the headers' do
        hashes.each do |hash|
          expect(hash.keys.sort).to eq(data_csv_reader.headers.sort)
        end
      end
    end

    context 'length' do
      subject { hashes.length }
      it { should == (data_csv_reader.rows.length - 1) }
    end
  end

end

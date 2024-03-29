require 'spec_helper'

describe OrderCsvImporter do
  let(:path) { Rails.root.join('spec', 'data', 'order_demo_import_data.csv').to_s }
  let(:order_csv_importer) { OrderCsvImporter.new(path) }

  before(:each) do
    order_csv_importer.row_hashes.each do |hash|
      FactoryGirl.create(:clinic, name: hash['Clinic'])
    end
  end

  describe '#order_name' do
    subject { order_csv_importer.order_name('Panda', '8/8/2013', 'Mixed', 'Promotional') }
    it { should == "Panda #{Order.model_name.human} (Mixed Promotional) on 8/8/2013" }
  end

  describe '#process_row_hash' do
    it do
      expect {
        order_csv_importer.process_row_hash(order_csv_importer.row_hashes.first)
      }.to change(Order, :count).by(1)
    end
  end

  describe '#value_to_float' do
    context 'given a monetary amount' do
      it { expect(order_csv_importer.value_to_float('$1.11')).to eq(1.11) }
    end

    context 'given an empty string' do
      it { expect(order_csv_importer.value_to_float('')).to eq(nil) }
    end

    context 'given nil' do
      it { expect(order_csv_importer.value_to_float(nil)).to eq(nil) }
    end
  end
end

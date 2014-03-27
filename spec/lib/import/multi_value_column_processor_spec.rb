require 'spec_helper'

describe MultiValueColumnProcessor do
  let(:test_column_data) { 'Panda, Bamboo, Curry (noodle)' }

  let(:test_transformation_map) do
    {
      'panda'          => :panda_column,
      'bamboo'         => :bamboo_column,
      'curry (noodle)' => :curry_column,
      'tree'           => :tree_column
    }
  end

  let(:multi_value_column_processor) { MultiValueColumnProcessor.new(test_column_data, test_transformation_map) }

  describe '#preprocess_column' do
    let(:processed_columns) { multi_value_column_processor.preprocess_column(test_column_data) }
    context 'given three values in the column' do
      context 'length' do
        it { expect(processed_columns.length).to be(3) }
      end
    end

    context 'given "-"' do
      it { expect(multi_value_column_processor.preprocess_column('-')).to eq([]) }
    end

    context 'values' do
      context 'with mixed-case values' do
        it do
          processed_columns.each {|value| expect(value).not_to match(/[A-Z]/) }
        end
      end

      context 'with whitespace' do
        it do
          processed_columns.each {|value| expect(value).not_to match(/(^\s|\s$)/) }
        end
      end
    end

    context 'given no value' do
      context 'nil' do
        subject { multi_value_column_processor.preprocess_column(nil) }
        it { should eq([]) }
      end

      context 'blank' do
        subject { multi_value_column_processor.preprocess_column('') }
        it { should eq([]) }
      end
    end
  end

  describe '#values_hash' do
    let(:values_hash) { multi_value_column_processor.values_hash }

    context 'given a found mapping' do
      [:panda_column, :bamboo_column, :curry_column].each do |column|
        context column do
          it { expect(values_hash[column]).to be(true) }
        end
      end
    end

    context 'given no provided value' do
      it { expect(values_hash[:tree_column]).to be(false) }
    end

    context 'given no found mapping' do
      it 'pukes' do
        expect do
          missing_column_data = "Panda, Missing (should fail terribly)"
          MultiValueColumnProcessor.new(missing_column_data, test_transformation_map).values_hash
        end.to raise_error(RuntimeError, "Don't know how to map value missing (should fail terribly)!")
      end
    end
  end
end

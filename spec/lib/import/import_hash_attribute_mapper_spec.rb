require 'spec_helper'

describe ImportHashAttributeMapper do
  let(:import_hash) do
    {
      "Date of most recent action/contact" => "8/5/2013",
      "Status" => "Signed up, called, and sending cards to",
      "Clinic name" => "City of Springfield Health Center",
      "Main contact name" => "Marge Simpson",
      "Main contact email" => "marge@springfieldhealth-center.org",
      "Email sent" => "Y",
      "Phone number" => "555-555-1234",
      "Follow-up call?" => nil,
      "Address line 1" => "742 Evergreen Terrace",
      "Address line 2" => nil,
      "City" => nil,
      "State" => "California",
      "Zip code" => "12345",
      "Title" => nil,
      "Clinic type" => "STD clinic",
      "What percent of your clients are women?" => "45",
      "What percent of your clients are men who have sex with men (MSM)?" => "5",
      "What percent of your clients are under 26?" => "60",
      "What percent of your clients are black/African American?" => "70",
      "What percent of your clients are hispanic/Latino(a)?" => "25",
      "How many people did you test last year for chlamydia?" => "1900",
      "How many did you test for gonorrhea?" => "1100",
      "How many did you test for trichomoniasis?" => "0",
      "How many did you diagnose with chlamydia?" => "225",
      "How many did you diagnose with gonorrhea?" => "150",
      "How may did you diagnose with trichomoniasis?" => "0",
      "How many did you test for HIV?" => "650",
      "How many did you diagnose with HIV?" => "6",
      "How much do you charge clients for a chlamydia test?" => "Free",
      "How do you deliver chlamydia test results?" => "on the phone",
      "Do you notify clients when their test results are ready?" => "Yes, for people who are positive",
      "Do you routinely ask clients if they are getting tested because of a partner notification?" => "Yes",
    }
  end

  let(:import_hash_attribute_mapper) { ImportHashAttributeMapper.new(import_hash) }

  describe '#mapped_attribute_hash' do
    let(:mapped_attribute_hash) { import_hash_attribute_mapper.mapped_attribute_hash }
    subject { mapped_attribute_hash }

    ImportHashAttributeMapper::ATTRIBUTE_MAP_TABLE.each do |src, dest|
      # both needed to ensure nil values get set explicitly!
      it { should have_key(dest) }
      it { expect(mapped_attribute_hash[dest]).to eq(import_hash[src]) }
    end
  end

  describe '#value_to_float' do
    context 'given "- " (notice the space)' do
      it { expect(import_hash_attribute_mapper.value_to_float '- ').to eq(0.0) }
    end

    context 'given nil' do
      it { expect(import_hash_attribute_mapper.value_to_float nil).to eq(0.0) }
    end

    context 'given a stringified float' do
      it { expect(import_hash_attribute_mapper.value_to_float '6.13').to eq(6.13) }
    end

    context 'given an actual float' do
      it { expect(import_hash_attribute_mapper.value_to_float 69.0).to eq(69) }
    end

    context 'given an int' do
      it { expect(import_hash_attribute_mapper.value_to_float 69).to eq(69) }
    end
  end
end

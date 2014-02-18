require 'spec_helper'

describe ClinicSignUpInteraction do
  let(:clinic) { FactoryGirl.build(:clinic) }
  let(:contact) { FactoryGirl.build(:contact, clinic: clinic) }

  let(:clinic_sign_up_interaction_attributes) do
    {
      :clinic_city => clinic.city,
      :clinic_name => clinic.name,
      :clinic_state => clinic.state,
      :clinic_street_address => clinic.street_address,
      :clinic_street_address_continued => clinic.street_address_continued,
      :clinic_zip => clinic.zip,
      # contact info
      :contact_email => contact.email,
      :contact_name => contact.name,
      :contact_phone => contact.phone,
      :contact_title => contact.title,
    }
  end

  let(:clinic_sign_up_interaction) { ClinicSignUpInteraction.run(clinic_sign_up_interaction_attributes) }

  it { should validate_presence_of(:clinic_name) }
  it { should validate_presence_of(:clinic_street_address) }
  it { should validate_presence_of(:clinic_city) }
  it { should validate_presence_of(:clinic_state) }
  it { should validate_presence_of(:clinic_zip) }

  it { should validate_presence_of(:contact_name) }
  it { should validate_presence_of(:contact_phone) }
  it { should validate_presence_of(:contact_email) }

  describe '#run' do
    context 'clinic' do
      it 'creates one' do
        expect {
          clinic_sign_up_interaction
        }.to change(Clinic, :count).by(1)
      end
    end

    context 'contact' do
      it 'creates one' do
        expect {
          clinic_sign_up_interaction
        }.to change(Contact, :count).by(1)
      end
    end
  end
end

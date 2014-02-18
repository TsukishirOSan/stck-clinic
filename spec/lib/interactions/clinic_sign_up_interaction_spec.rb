require 'spec_helper'

describe ClinicSignUpInteraction do
  let(:clinic) { FactoryGirl.build(:clinic) }
  let(:contact) { FactoryGirl.build(:contact, clinic: clinic) }

  let(:clinic_sign_up_interaction_attributes) do
    {
      :clinic_name => clinic.name,
      :clinic_street_address => clinic.street_address,
      :clinic_street_address_continued => clinic.street_address_continued,
      :clinic_city => clinic.city,
      :clinic_state => clinic.state,
      :clinic_zip => clinic.zip
    }
  end

  let(:clinic_sign_up_interaction) { ClinicSignUpInteraction.run(clinic_sign_up_interaction_attributes) }

  it { should validate_presence_of(:clinic_name) }
  it { should validate_presence_of(:clinic_street_address) }
  it { should validate_presence_of(:clinic_city) }
  it { should validate_presence_of(:clinic_state) }
  it { should validate_presence_of(:clinic_zip) }

  describe '#run' do
    context 'clinic' do
      it 'creates one' do
        expect {
          clinic_sign_up_interaction
        }.to change(Clinic, :count).by(1)
      end
    end
  end
end

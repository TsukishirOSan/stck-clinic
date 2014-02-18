require 'spec_helper'

describe ClinicSignUpInteraction do
  let(:clinic) { FactoryGirl.build(:clinic) }
  let(:contact) { FactoryGirl.build(:contact, clinic: clinic) }
  let(:service_offering_description) { FactoryGirl.build(:service_offering_description, clinic: clinic) }

  let(:clinic_sign_up_interaction_attributes) do
    {
      :clinic_city                     => clinic.city,
      :clinic_name                     => clinic.name,
      :clinic_state                    => clinic.state,
      :clinic_street_address           => clinic.street_address,
      :clinic_street_address_continued => clinic.street_address_continued,
      :clinic_zip                      => clinic.zip,
      # contact info
      :contact_email                   => contact.email,
      :contact_name                    => contact.name,
      :contact_phone                   => contact.phone,
      :contact_title                   => contact.title,
      # service info
      :college_health                  => service_offering_description.college_health,
      :community_health                => service_offering_description.community_health,
      :family_planning                 => service_offering_description.family_planning,
      :planned_parenthood              => service_offering_description.planned_parenthood,
      :private_practice                => service_offering_description.private_practice,
      :std                             => service_offering_description.std,
      :other                           => service_offering_description.other,
    }
  end

  let(:clinic_sign_up_interaction) { ClinicSignUpInteraction.run(clinic_sign_up_interaction_attributes) }
  #clinic info
  it { should validate_presence_of(:clinic_name) }
  it { should validate_presence_of(:clinic_street_address) }
  it { should validate_presence_of(:clinic_city) }
  it { should validate_presence_of(:clinic_state) }
  it { should validate_presence_of(:clinic_zip) }
  # contact info
  it { should validate_presence_of(:contact_name) }
  it { should validate_presence_of(:contact_phone) }
  it { should validate_presence_of(:contact_email) }
  # service offering info
  #########################################################
  # it { should validate_presence_of(:college_health) }   #
  # it { should validate_presence_of(:community_health) } #
  # it { should validate_presence_of(:family_planning) }  #
  # it { should validate_presence_of(:private_practice) } #
  # it { should validate_presence_of(:std) }              #
  # it { should validate_presence_of(:other) }            #
  #########################################################

  describe '#valid?' do
    context 'given valid attributes' do
      it 'validates' do
        expect(clinic_sign_up_interaction).to be_valid
      end
    end

    context 'given invalid attributes' do
      context 'given no services selected' do
        it 'fails validation' do
          [
            :college_health,
            :community_health,
            :family_planning,
            :other,
            :planned_parenthood,
            :private_practice,
            :std,
          ].each do |attr|
            service_offering_description.public_send("#{attr}=", false)
          end

          expect(clinic_sign_up_interaction).not_to be_valid
        end
      end
    end
  end

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

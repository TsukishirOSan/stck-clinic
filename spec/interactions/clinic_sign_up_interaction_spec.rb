require 'spec_helper'

describe ClinicSignUpInteraction do
  let(:clinic) { FactoryGirl.build(:clinic) }

  let(:contact) { FactoryGirl.build(:contact, clinic: clinic) }
  let(:service_offering_description) { FactoryGirl.build(:service_offering_description, clinic: clinic) }
  let(:population_breakdown) { FactoryGirl.build(:population_breakdown, clinic: clinic) }
  let(:epi_breakdown) { FactoryGirl.build(:epi_breakdown, clinic: clinic) }

  let(:clinic_sign_up_interaction_attributes) do
    {
      :clinic_city                        => clinic.city,
      :clinic_name                        => clinic.name,
      :clinic_state                       => clinic.state,
      :clinic_street_address              => clinic.street_address,
      :clinic_street_address_continued    => clinic.street_address_continued,
      :clinic_zip                         => clinic.zip,
      :clinic_notes                       => clinic.notes,
      # contact info
      :contact_email                      => contact.email,
      :contact_name                       => contact.name,
      :contact_phone                      => contact.phone,
      :contact_title                      => contact.title,
      # service info
      :college_health                     => service_offering_description.college_health,
      :community_health                   => service_offering_description.community_health,
      :family_planning                    => service_offering_description.family_planning,
      :planned_parenthood                 => service_offering_description.planned_parenthood,
      :private_practice                   => service_offering_description.private_practice,
      :std                                => service_offering_description.std,
      :other                              => service_offering_description.other,
      :charge_ct                          => service_offering_description.charge_ct,
      :notify_test_ready                  => service_offering_description.notify_test_ready,
      :deliver_results_online             => service_offering_description.deliver_results_online,
      :deliver_results_in_person          => service_offering_description.deliver_results_in_person,
      :deliver_results_on_phone_human     => service_offering_description.deliver_results_on_phone_human,
      :deliver_results_on_phone_automated => service_offering_description.deliver_results_on_phone_automated,
      :deliver_results_other              => service_offering_description.deliver_results_other,
      # population breakdown info
      :population_women                   => population_breakdown.women,
      :population_msm                     => population_breakdown.msm,
      :population_under_26                => population_breakdown.under_26,
      :population_black                   => population_breakdown.black,
      :population_hispanic                => population_breakdown.hispanic,
      # epi breakdown (testing and diagnoses)
      :test_ct                            => epi_breakdown.test_ct,
      :diag_ct                            => epi_breakdown.diag_ct,
      :test_gc                            => epi_breakdown.test_gc,
      :diag_gc                            => epi_breakdown.diag_gc,
      :test_trich                         => epi_breakdown.test_trich,
      :diag_trich                         => epi_breakdown.diag_trich,
      :test_hiv                           => epi_breakdown.test_hiv,
      :diag_hiv                           => epi_breakdown.diag_hiv
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

  describe '#valid?' do
    context 'given valid attributes' do
      it 'validates' do
        expect(clinic_sign_up_interaction).to be_valid
      end
    end
  end

  describe '#run' do
    context 'Clinic' do
      it 'creates one' do
        expect {
          clinic_sign_up_interaction
        }.to change(Clinic, :count).by(1)
      end
    end

    context 'Contact' do
      it 'creates one' do
        expect {
          clinic_sign_up_interaction
        }.to change(Contact, :count).by(1)
      end
    end

    context 'ServiceOfferingDescription' do
      it 'creates one' do
        expect {
          clinic_sign_up_interaction
        }.to change(ServiceOfferingDescription, :count).by(1)
      end
    end

    context 'PopulationBreakdown' do
      it 'creates one' do
        expect {
          clinic_sign_up_interaction
        }.to change(PopulationBreakdown, :count).by(1)
      end
    end

    context 'EpiBreakdown' do
      it 'creates one' do
        expect {
          clinic_sign_up_interaction
        }.to change(EpiBreakdown, :count).by(1)
      end
    end
  end
end

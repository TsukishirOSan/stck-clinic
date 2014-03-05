# == Schema Information
#
# Table name: service_offering_descriptions
#
# *charge_ct*::                          <tt>string(255)</tt>
# *clinic_id*::                          <tt>integer</tt>
# *college_health*::                     <tt>boolean</tt>
# *community_health*::                   <tt>boolean</tt>
# *created_at*::                         <tt>datetime</tt>
# *deliver_results_in_person*::          <tt>boolean</tt>
# *deliver_results_on_phone_automated*:: <tt>boolean</tt>
# *deliver_results_on_phone_human*::     <tt>boolean</tt>
# *deliver_results_online*::             <tt>boolean</tt>
# *deliver_results_other*::              <tt>boolean</tt>
# *family_planning*::                    <tt>boolean</tt>
# *id*::                                 <tt>integer, not null, primary key</tt>
# *name*::                               <tt>string(255)</tt>
# *notify_test_ready*::                  <tt>string(255)</tt>
# *other*::                              <tt>boolean</tt>
# *planned_parenthood*::                 <tt>boolean</tt>
# *private_practice*::                   <tt>boolean</tt>
# *std*::                                <tt>boolean</tt>
# *updated_at*::                         <tt>datetime</tt>
#--
# == Schema Information End
#++

require 'spec_helper'

describe ServiceOfferingDescription do
  let(:service_offering_description) { FactoryGirl.build(:service_offering_description) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:clinic) }
  it { should validate_presence_of(:clinic) }

  describe '#valid?' do
    context 'given valid attributes' do
      it 'validates' do
        expect(service_offering_description).to be_valid
      end
    end

    context 'given invalid attributes' do
      context 'given no services offered' do
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

          expect(service_offering_description).not_to be_valid
        end
      end

      it { should ensure_inclusion_of(:charge_ct).in_array(ServiceOfferingDescription::CHARGE_CT_OPTIONS) }
      it { should ensure_inclusion_of(:notify_test_ready).in_array(ServiceOfferingDescription::NOTIFY_TEST_READY_OPTIONS) }

    end
  end

  describe 'RailsAdmin Enumerations' do
    describe '#charge_ct_enum' do
      it 'returns options' do
        expect(service_offering_description.charge_ct_enum)
          .to eq(ServiceOfferingDescription::CHARGE_CT_OPTIONS)
      end
    end

    describe '#notify_test_ready_enum' do
      it 'returns options' do
        expect(service_offering_description.notify_test_ready_enum)
          .to eq(ServiceOfferingDescription::NOTIFY_TEST_READY_OPTIONS)
      end
    end
  end
end

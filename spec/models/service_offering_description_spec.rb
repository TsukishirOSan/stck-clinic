# == Schema Information
#
# Table name: service_offering_descriptions
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  clinic_id          :integer
#  college_health     :boolean
#  community_health   :boolean
#  family_planning    :boolean
#  planned_parenthood :boolean
#  private_practice   :boolean
#  std                :boolean
#  other              :boolean
#  created_at         :datetime
#  updated_at         :datetime
#

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
end

require 'spec_helper'

describe ServiceOfferingDescription do
  let(:service_offering_description) { FactoryGirl.build(:service_offering_description) }
  it { should validate_presence_of(:name) }
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
    end
  end
end

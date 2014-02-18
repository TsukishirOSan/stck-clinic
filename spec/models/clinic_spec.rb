require 'spec_helper'

describe Clinic do
  it { should validate_presence_of(:name) }
  # basic info
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:zip) }

  describe '#valid?' do
    context 'given valid attributes' do
      it 'validates' do
        expect(FactoryGirl.build(:clinic)).to be_valid
      end
    end
  end
end

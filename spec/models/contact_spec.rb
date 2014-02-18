require 'spec_helper'

describe Contact do
  # contact info

  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :clinic }

  describe '#valid?' do
    context 'given valid attributes' do
      it 'validates' do
        expect(FactoryGirl.build(:contact)).to be_valid
      end
    end
  end
end

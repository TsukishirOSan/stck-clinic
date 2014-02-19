# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  phone      :string(255)
#  email      :string(255)
#  notes      :text
#  clinic_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Contact do
  # contact info
  it { should belong_to(:clinic) }
  it { should validate_presence_of :clinic }

  it { should validate_presence_of :email }
  it { should validate_presence_of :name }
  it { should validate_presence_of :phone }

  describe '#valid?' do
    context 'given valid attributes' do
      it 'validates' do
        expect(FactoryGirl.build(:contact)).to be_valid
      end
    end
  end
end

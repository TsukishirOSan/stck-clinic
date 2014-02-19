# == Schema Information
#
# Table name: clinics
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  street_address           :string(255)
#  city                     :string(255)
#  state                    :string(255)
#  zip                      :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  street_address_continued :string(255)
#  notes                    :text
#

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

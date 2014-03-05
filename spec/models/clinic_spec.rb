# == Schema Information
#
# Table name: clinics
#
# *city*::                     <tt>string(255)</tt>
# *created_at*::               <tt>datetime</tt>
# *id*::                       <tt>integer, not null, primary key</tt>
# *name*::                     <tt>string(255)</tt>
# *notes*::                    <tt>text</tt>
# *state*::                    <tt>string(255)</tt>
# *street_address*::           <tt>string(255)</tt>
# *street_address_continued*:: <tt>string(255)</tt>
# *updated_at*::               <tt>datetime</tt>
# *zip*::                      <tt>string(255)</tt>
#--
# == Schema Information End
#++

require 'spec_helper'

describe Clinic do
  it { should validate_presence_of(:name) }
  # associations
  it { should have_one(:contact) }
  it { should have_one(:population_breakdown) }
  it { should have_one(:service_offering_description) }
  it { should have_one(:epi_breakdown) }
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

# == Schema Information
#
# Table name: contacts
#
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string(255)</tt>
# *title*::      <tt>string(255)</tt>
# *phone*::      <tt>string(255)</tt>
# *email*::      <tt>string(255)</tt>
# *notes*::      <tt>text</tt>
# *clinic_id*::  <tt>integer</tt>
# *created_at*:: <tt>datetime</tt>
# *updated_at*:: <tt>datetime</tt>
#--
# == Schema Information End
#++

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

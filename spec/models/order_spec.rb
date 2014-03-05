# == Schema Information
#
# Table name: orders
#
# *brochure_quantity*:: <tt>integer</tt>
# *card_quantity*::     <tt>integer</tt>
# *clinic_code*::       <tt>string(255)</tt>
# *clinic_id*::         <tt>integer</tt>
# *created_at*::        <tt>datetime</tt>
# *envelope_cost*::     <tt>float</tt>
# *id*::                <tt>integer, not null, primary key</tt>
# *name*::              <tt>string(255)</tt>
# *notes*::             <tt>text</tt>
# *postage_cost*::      <tt>float</tt>
# *sent_on*::           <tt>date</tt>
# *type*::              <tt>string(255)</tt>
# *updated_at*::        <tt>datetime</tt>
# *use*::               <tt>string(255)</tt>
#--
# == Schema Information End
#++

require 'spec_helper'

describe Order do
  it { should belong_to(:clinic) }

  it { should validate_presence_of(:card_quantity) }
  it { should validate_presence_of(:brochure_quantity) }
  it { should validate_numericality_of(:card_quantity) }
  it { should validate_numericality_of(:brochure_quantity) }

  it { should ensure_inclusion_of(:use).in_array(Order::USE_OPTIONS) }
  it { should ensure_inclusion_of(:type).in_array(Order::TYPE_OPTIONS) }

  describe '#valid?' do
    context 'given valid attributes' do
      it { expect(FactoryGirl.build(:order)).to be_valid }
    end
  end
end

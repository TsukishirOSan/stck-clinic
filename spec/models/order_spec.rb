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
# *order_type*::        <tt>string(255)</tt>
# *postage_cost*::      <tt>float</tt>
# *sent_on*::           <tt>date</tt>
# *status*::            <tt>string(255)</tt>
# *updated_at*::        <tt>datetime</tt>
# *use*::               <tt>string(255)</tt>
#--
# == Schema Information End
#++

require 'spec_helper'

describe Order do
  let(:order) { FactoryGirl.build(:order) }

  it { should belong_to(:clinic) }

  it { should validate_presence_of(:card_quantity) }
  it { should validate_presence_of(:brochure_quantity) }
  it { should validate_numericality_of(:card_quantity) }
  it { should validate_numericality_of(:brochure_quantity) }

  it { should ensure_inclusion_of(:use).in_array(Order::USE_OPTIONS) }
  it { should ensure_inclusion_of(:order_type).in_array(Order::TYPE_OPTIONS) }
  it { should ensure_inclusion_of(:status).in_array(Order::STATUS_OPTIONS) }

  describe '#valid?' do
    context 'given valid attributes' do
      it { expect(order).to be_valid }
    end
  end

  describe '#use_enum' do
    it { expect(order.use_enum).to eq(Order::USE_OPTIONS) }
  end

  describe '#order_type_enum' do
    it { expect(order.order_type_enum).to eq(Order::TYPE_OPTIONS) }
  end

  describe '#status_enum' do
    it { expect(order.status_enum).to eq(Order::STATUS_OPTIONS) }
  end

  describe '#name' do
    context 'given no name' do
      it 'creates one' do
        order.name = nil
        order.save!
        expect(order.name.length).to be > 0
      end
    end

    context 'given a name' do
      it 'leaves it alone' do
        name_before = order.name
        order.save!
        expect(order.name).to eq(name_before)
      end
    end
  end

  describe 'status' do
    context 'when sent_on gets Sent' do
      it 'changes to Sent' do
        order.status = 'Unsent'
        order.sent_on = nil
        order.save!
        expect(order.status).to eq('Unsent')
        order.sent_on = Date.today
        order.save!
        expect(order.status).to eq('Sent')
      end
    end
  end
end

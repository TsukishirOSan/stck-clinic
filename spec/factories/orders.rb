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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    sequence(:name) {|n| "Order #{n}" }

    envelope_cost 1.5
    notes "Notes notes notes notes notes"
    order_type { Order::TYPE_OPTIONS.first }
    postage_cost 1.5
    sent_on { 5.days.ago }
    sequence(:brochure_quantity) {|n| n}
    sequence(:card_quantity) {|n| n }
    sequence(:clinic_code) {|n| "Clinic Code #{n}" }
    status { Order::STATUS_OPTIONS.first }
    use { Order::USE_OPTIONS.first }

    clinic
  end
end

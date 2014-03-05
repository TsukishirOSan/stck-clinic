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
    sequence(:card_quantity) {|n| n }
    sequence(:brochure_quantity) {|n| n}
    sent_on { 5.days.ago }
    # FIXME: make these enums
    type { Order::TYPE_OPTIONS.first }
    use { Order::USE_OPTIONS.first }
    envelope_cost 1.5
    postage_cost 1.5
    sequence(:clinic_code) {|n| "Clinic Code #{n}" }
    notes "Notes notes notes notes notes"

    clinic
  end
end

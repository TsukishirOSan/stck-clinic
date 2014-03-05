# == Schema Information
#
# Table name: contacts
#
# *clinic_id*::  <tt>integer</tt>
# *created_at*:: <tt>datetime</tt>
# *email*::      <tt>string(255)</tt>
# *id*::         <tt>integer, not null, primary key</tt>
# *name*::       <tt>string(255)</tt>
# *notes*::      <tt>text</tt>
# *phone*::      <tt>string(255)</tt>
# *title*::      <tt>string(255)</tt>
# *updated_at*:: <tt>datetime</tt>
#--
# == Schema Information End
#++

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    sequence(:email) {|n| "contact.email#{n}@example.com" }
    sequence(:name)  {|n| "Contact name #{n}" }
    sequence(:notes) {|n| "Contact notes #{n}" }
    sequence(:phone) {|n| "212-555-999#{n}" }
    sequence(:title) {|n| "Contact title #{n}" }

    clinic
  end
end

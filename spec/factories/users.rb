# == Schema Information
#
# Table name: users
#
# *admin*::                  <tt>boolean</tt>
# *created_at*::             <tt>datetime</tt>
# *current_sign_in_at*::     <tt>datetime</tt>
# *current_sign_in_ip*::     <tt>string(255)</tt>
# *email*::                  <tt>string(255), default(""), not null</tt>
# *encrypted_password*::     <tt>string(255), default(""), not null</tt>
# *id*::                     <tt>integer, not null, primary key</tt>
# *last_sign_in_at*::        <tt>datetime</tt>
# *last_sign_in_ip*::        <tt>string(255)</tt>
# *name*::                   <tt>string(255)</tt>
# *remember_created_at*::    <tt>datetime</tt>
# *reset_password_sent_at*:: <tt>datetime</tt>
# *reset_password_token*::   <tt>string(255)</tt>
# *sign_in_count*::          <tt>integer, default(0), not null</tt>
# *updated_at*::             <tt>datetime</tt>
#--
# == Schema Information End
#++

FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "User #{n}" }
    sequence(:email) {|n| "user.email.#{n}@example.com" }
    password 'SomeSortOfPassword'
    password_confirmation 'SomeSortOfPassword'
    admin false
  end
end

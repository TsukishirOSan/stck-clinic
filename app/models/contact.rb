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

# The Contact model expresses a human being at the clinic who serves
# as our primary point person for communication.
class Contact < ActiveRecord::Base
  belongs_to :clinic

  validates :clinic, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validates :phone, presence: true
end

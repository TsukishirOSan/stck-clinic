# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  phone      :string(255)
#  email      :string(255)
#  notes      :text
#  clinic_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  belongs_to :clinic
  
  validates :clinic, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validates :phone, presence: true
end
